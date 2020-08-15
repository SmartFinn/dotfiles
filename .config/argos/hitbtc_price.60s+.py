#!/usr/bin/env python3

"""
Created on Fri, 11 Aug 2017 05:41:46 +0300

@author: SmartfFinn
@documentation: https://github.com/hitbtc-com/hitbtc-api/blob/master/APIv2.md
"""

import os
import requests


class HitBTCMarket(object):
    __DEFAULT_BASE_URL = 'https://api.hitbtc.com/api/2/'
    __DEFAULT_TIMEOUT = 120

    def __init__(self, public_key=None, secret=None,
                 base_url=__DEFAULT_BASE_URL,
                 request_timeout=__DEFAULT_TIMEOUT):
        self.base_url = base_url
        self.request_timeout = request_timeout
        self.session = requests.session()

        if public_key and secret:
            self.session.auth = (public_key, secret)

    def __request(self, endpoint, params=''):
        response_object = self.session.get(self.base_url + endpoint,
                                           params=params,
                                           timeout=self.request_timeout)

        assert response_object.status_code == 200, '%s' % response_object.text

        try:
            response = response_object.json()
        except requests.exceptions.RequestException as e:
            return e

        return response

    def __pair(self, pair):
        return {'BTXUSD': 'BTXUSDT',
                'LCCUSD': 'LCCBTC',
                'ETHBNTUSD': 'ETHBNTBTC',
                'USDUSD': 'USDTUSD',
                'JSTUSD': 'JSTUSDT',
                'XRPUSD': 'XRPUSDT',
                'SBTCUSD': 'SBTCUSDT',
                'EMCUSD': 'EMCUSDT',
                }.get(pair.upper(), pair.upper())

    def get_ticker(self, pair=''):
        """Get ticker."""
        response = self.__request('public/ticker/' + self.__pair(pair))

        return response

    def get_symbol(self, pair=''):
        """Get symbol."""
        response = self.__request('public/symbol/' + self.__pair(pair))

        return response

    def get_symbols(self):
        """Get symbol."""
        response = self.__request('public/symbol/')

        return response

    def get_lastPrice(self, pair):
        ticker = self.get_ticker(pair)

        return float(ticker['last'])

    def get_price(self, symbol, currency='USD'):
        pair = symbol + currency
        ticker = self.get_ticker(pair)

        return ticker['last']

    def get_balance(self):
        response = self.__request('trading/balance')

        return response

    @property
    def own_currencies(self):
        balance = self.get_balance()

        return tuple(i['currency'] for i in balance if float(i['available']) > 0
                     or float(i['reserved']) > 0)


if __name__ == "__main__":
    ignore_currencies = ['ETHBNT', 'LCC']
    menu_open = os.getenv('ARGOS_MENU_OPEN')

    public_key = os.getenv('HITBTC_PUBLIC_KEY', None)
    secret_key = os.getenv('HITBTC_SECRET_KEY', None)

    hitbtc = HitBTCMarket(public_key=public_key, secret=secret_key,
                          request_timeout=10)

    print("${:.0f}".format(float(hitbtc.get_ticker('BTCUSD')['last'])))
    print("---")

    if menu_open == 'true':
        for currency in sorted(hitbtc.own_currencies):
            if currency in ignore_currencies:
                continue

            ticker = hitbtc.get_ticker(currency + 'USD')

            symbol = ticker['symbol']
            open_price = float(ticker['open'])
            last_price = float(ticker['last'])
            change_percent = (last_price - open_price) / open_price * 100

            if change_percent < 0:
                percent = "({0:.2f}%)".format(change_percent)
            elif change_percent == 0:
                percent = "({0:.2f}%)".format(change_percent)
            else:
                percent = '(+{0:.2f}%)'.format(change_percent)

            print(f"{symbol:10} {last_price:12.4f} {percent:10}",
                  f"| font=monospace href=https://hitbtc.com/exchange/{symbol}")
