#!/usr/bin/env python3
#
# A Rofi plugin that allows to jump to your YouTube subscriptions
# Inspired by https://github.com/AlbertExtensions/Github-Jump
#
# Copyright (c) 2022 Sergei Eremenko (https://github.com/SmartFinn)
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

import os
import sys
import requests
import json
import subprocess

SUBSCRIPTION_API_URL = 'https://www.googleapis.com/youtube/v3/subscriptions'
CHANNEL_URL_PREFIX = 'https://www.youtube.com/channel/'
API_KEY = os.getenv('YOUTUBE_API_KEY', None)
CHANNEL_ID = os.getenv('YOUTUBE_CHANNEL_ID', None)
MAX_RESULTS = 50

XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME", os.path.expanduser("~/.cache"))
CACHE_FILE = os.path.join(XDG_CACHE_HOME, 'rofi-yt-jump.json')

SYMBOL_MAP = {'А': 'A', 'а': 'a', 'Б': 'B', 'б': 'b',
              'В': 'V', 'в': 'v', 'Г': 'G', 'г': 'g',
              'Д': 'D', 'д': 'd', 'Е': 'E', 'е': 'e',
              'Є': 'Ie', 'є': 'ie', 'Ё': 'E', 'ё': 'e',
              'Ж': 'Zh', 'ж': 'zh', 'З': 'Z', 'з': 'z',
              'И': 'I', 'и': 'i', 'І': 'I', 'і': 'i',
              'Ї': 'I', 'ї': 'i', 'Й': 'I', 'й': 'i',
              'К': 'K', 'к': 'k', 'Л': 'L', 'л': 'l',
              'М': 'M', 'м': 'm', 'Н': 'N', 'н': 'n',
              'О': 'O', 'о': 'o', 'П': 'P', 'п': 'p',
              'Р': 'R', 'р': 'r', 'С': 'S', 'с': 's',
              'Т': 'T', 'т': 't', 'У': 'U', 'у': 'u',
              'Ф': 'F', 'ф': 'f', 'Х': 'Kh', 'х': 'kh',
              'Ц': 'Ts', 'ц': 'ts', 'Ч': 'Ch', 'ч': 'ch',
              'Ш': 'Sh', 'ш': 'sh', 'Щ': 'Shch', 'щ': 'shch',
              'Ь': "'", 'ь': "'", 'Ы': 'Y', 'ы': 'y',
              'Ъ': "'", 'Ъ': "'", 'Э': 'E', 'э': 'e',
              'Ю': 'Yu', 'ю': 'yu', 'Я': 'Ya', 'я': 'ya'}

ENTRY_TEMPLATE = (
    '{title}'
    ' <span weight="light" size="small"><i>({description})</i></span>'
    '\0meta\x1f{alt_title}'
    '\x1finfo\x1f{action}'
)

MESSAGE_TEMPLATE = '\0message\x1f<span weight="light" size="small">{}</span>'
SUCCESS_TEMPLATE = '\0message\x1f<span size="small" fgcolor="#3ddd3d">{}</span>'
ERROR_TEMPLATE = '\0message\x1f<span size="small" fgcolor="#dd3d3d">{}</span>'


class Channel:
    def __init__(self, snippet: dict):
        self.published_at = snippet['publishedAt']
        self.title = snippet['title']
        self.alt_title = self._translit(self.title)
        self.description = snippet['description'].split('\n')[0].strip()
        self.channel_id = snippet['resourceId']['channelId']
        self.url = CHANNEL_URL_PREFIX + self.channel_id
        self.action = self.url

    def __getitem__(self, key):
        return self.__dict__[key]

    def __setitem__(self, key, value):
        self.__dict__[key] = value

    def __repr__(self):
        return "<{} {}>".format(self.__class__.__name__, self.__dict__)

    def __str__(self):
        return ENTRY_TEMPLATE.format(**self.__dict__)

    def _translit(self, text):
        return text.translate(text.maketrans(SYMBOL_MAP))

    def update(self, **kwargs):
        return self.__dict__.update(**kwargs)


def request_api(api_url, params):
    try:
        response = requests.get(api_url, params=params)
    except Exception as e:
        print(ERROR_TEMPLATE.format(e))
        sys.exit(1)
    else:
        if response.status_code != 200:
            print(ERROR_TEMPLATE.format(response.text))
        return response.json()


def get_youtube_subscriptions():
    params = {
        'part': 'snippet',
        'channelId': CHANNEL_ID,
        'key': API_KEY,
        'maxResults': MAX_RESULTS,
        'pageToken': None,
    }
    snippets = []
    response = request_api(SUBSCRIPTION_API_URL, params)
    items = response['items']

    if response.get('nextPageToken') is not None:
        params['pageToken'] = response['nextPageToken']
        response = request_api(SUBSCRIPTION_API_URL, params)
        items.extend(response['items'])

    for item in items:
        snippets.append(item['snippet'])

    sorted_snippets = sorted(snippets, key=lambda k: k['title'].lower())

    return sorted_snippets


def cache_save(obj):
    try:
        with open(CACHE_FILE, "w") as f:
            json.dump(obj, f, indent=2)
    except Exception as e:
        print(ERROR_TEMPLATE.format(f"Error while saving JSON file): {e}"))


def cache_load():
    try:
        with open(CACHE_FILE, "r") as f:
            return json.load(f)
    except Exception as e:
        print(ERROR_TEMPLATE.format(f"Error while reading JSON file: {e}"))


def cache_update():
    channels = get_youtube_subscriptions()
    cache_save(channels)
    return channels


def exists_and_not_empty(file):
    if not os.path.exists(file):
        return False

    if os.path.getsize(file) == 0:
        return False

    return True


if __name__ == '__main__':
    channels = []

    # Enable Pango markup
    print('\0markup-rows\x1ftrue')

    if API_KEY is None or CHANNEL_ID is None:
        print(ERROR_TEMPLATE.format(
            "'YOUTUBE_API_KEY' or 'YOUTUBE_CHANNEL_ID'"
            "environment variables are missing. Please setup it before use."
        ))
        sys.exit(1)

    action = os.getenv('ROFI_INFO', None)

    if action is not None and action.startswith('http'):
        # FIXME: a hack to suppress output of browsers when using
        # webbrowser.open_new_tab(action)
        subprocess.Popen(['python', '-m', 'webbrowser', '-t', action],
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        sys.exit(0)
    elif action == "update":
        channels = cache_update()
        print(SUCCESS_TEMPLATE.format("Successfully updated."))

    print(ENTRY_TEMPLATE.format(
        title="!update",
        description="update list of YouTube subscription",
        alt_title="refresh",
        action="update",
    ))

    if len(channels) == 0:
        if exists_and_not_empty(CACHE_FILE):
            channels = cache_load()
        else:
            cnannels = cache_update()

    for channel in channels:
        print(Channel(channel))
