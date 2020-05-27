#!/usr/bin/env python3

# <bitbar.title>GitHub Notifications</bitbar.title>
# <bitbar.version>v3.0.2</bitbar.version>
# <bitbar.author>Matt Sephton, Keith Cirkel, John Flesch</bitbar.author>
# <bitbar.author.github>flesch</bitbar.author.github>
# <bitbar.desc>GitHub notifications in your menu bar!</bitbar.desc>
# <bitbar.image>https://i.imgur.com/hW7dw9E.png</bitbar.image>
# <bitbar.dependencies>python</bitbar.dependencies>

# Setup
#
# Add GITHUB_TOKEN environment variable to ~/.profile:
#     export GITHUB_TOKEN=YOUR_GITHUB_ACCESS_TOKEN

import json
import urllib3
import os
import sys
import re
from itertools import groupby

# GitHub.com
GITHUB_API_URL = 'https://api.github.com'
GITHUB_API_KEY = os.getenv('GITHUB_TOKEN', None)
NOTIFICATION_TYPE_ICONS={
    'PullRequest':          'pull-request-symbolic',
    'RepositoryInvitation': 'user-symbolic',
    'Issue':                'issue-opened-symbolic',
    'Commit':               'git-commit-symbolic',
    'Release':              'tag-symbolic',
}


def plural(word, n):
    return str(n) + ' ' + (word + 's' if n > 1 else word)


def get_dict_subset(thedict, *keys):
    return dict([(key, thedict[key]) for key in keys if key in thedict])


def print_bitbar_line(title, **kwargs):
    print(title + '|' + (' '.join(['{}={}'.format(k, v) for k, v in kwargs.items()])))


def make_github_request(url, method='GET', data=None):
    try:
        api_key = GITHUB_API_KEY
        headers = {
            'Authorization': 'token %s' % api_key,
            'Accept': 'application/json',
            'User-Agent': 'python-urllib3',
        }
        if data is not None:
            data = json.dumps(data).encode('utf-8')
            headers['Content-Type'] = 'application/json'
            headers['Contnet-Length'] = len(data)
        http = urllib3.PoolManager()
        response = http.request(method, url, headers=headers, body=data)

        return json.loads(response.data.decode('utf8')) if int(response.headers.get('content-length', 0)) > 0 else {}
    except Exception:
        return None


def get_notifications():
    url = '%s/notifications' % GITHUB_API_URL
    return make_github_request(url) or []


def print_notifications(notifications):
    notifications = sorted(notifications, key=lambda notification: notification['repository']['full_name'])
    for repo, repo_notifications in groupby(notifications, key=lambda notification: notification['repository']['full_name']):
        if repo:
            repo_notifications = list(repo_notifications)
            print_bitbar_line(
                title='{title} ({count})'.format(title=repo, count=len(repo_notifications)),
                iconName='repo-symbolic'
            )
            print_bitbar_line(
                title='{title} ({count})'.format(title=repo, count=len(repo_notifications)),
                iconName='ok-symbolic',
                alternate='true',
                refresh='true',
                bash=__file__,
                terminal='false',
                param1='readrepo',
                param2=repo,
            )
            for notification in repo_notifications:
                formatted_notification = format_notification(notification)
                print_bitbar_line(refresh='true', **get_dict_subset(formatted_notification, 'title', 'href', 'iconName'))
                print_bitbar_line(
                    refresh='true',
                    iconName='ok-symbolic',
                    alternate='true',
                    bash=__file__,
                    terminal='false',
                    param1='readthread',
                    param2=notification['url'],
                    **get_dict_subset(formatted_notification, 'title')
                )


def format_notification(notification):
    notification_type = notification['subject']['type']
    formatted = {
        'title': notification['subject']['title'],
        'href': notification['subject']['url'],
        'iconName': NOTIFICATION_TYPE_ICONS[notification_type],
    }

    if len(formatted['title']) > 80:
        formatted['title'] = formatted['title'][:79] + '…'

    formatted['title'] = formatted['title'].replace('|', '-')

    # Add a link to a comment, if available
    latest_comment_url = notification.get('subject', {}).get('latest_comment_url', None)
    if latest_comment_url:
        split_url = latest_comment_url.split('/')
        if split_url[-2] in 'comments':
            formatted['href'] += '#issuecomment-%s' % (split_url[-1])

    # Transform API URL to a web-viewable URL
    if formatted['href']:
        formatted['href'] = re.sub(r'api\.|api/v3/|repos/', '', re.sub('(pull|commit)s', r'\1', formatted['href']))

    if (notification_type == 'Commit'):
        formatted['href'] = re.sub(r'#issuecomment-', '#commitcomment-', formatted['href'])
    elif (notification_type == 'Release'):
        formatted['href'] = 'https://github.com/{}/releases'.format(notification['repository']['full_name'])
    elif (notification_type == 'RepositoryInvitation'):
        formatted['href'] = 'https://github.com/{}/invitations'.format(notification['repository']['full_name'])

    return formatted


if __name__ == "__main__":
    if len(sys.argv) > 1:
        command = sys.argv[1]
        args = sys.argv[2:]
        if command == 'readrepo':
            url = '%s/repos/%s/notifications' % (GITHUB_API_URL, args[0])
            print('Marking %s as read' % url)
            make_github_request(url=url, method='PUT', data={})
        elif command == 'readthread':
            url = args[0]
            print('Marking %s as read' % url)
            make_github_request(url=url, method='PATCH', data={})

    else:
        is_github_defined = bool(GITHUB_API_KEY)
        github_notifications = get_notifications() if is_github_defined else []
        has_notifications = len(github_notifications)

        if not is_github_defined:
            print(os.path.basename(__file__))
            print('---')
            print('GITHUB_TOKEN is not set.')
            sys.exit(0)

        if has_notifications:
            print_bitbar_line('', iconName='github-notifications-symbolic')
            print('---')
            print_bitbar_line(title='Refresh', refresh='true')
            print_bitbar_line(
                title=('GitHub \u2014 %s' % plural('notification', len(github_notifications))),
                href='https://github.com/notifications',
            )
            print_notifications(github_notifications)
        else:
            print('---')
