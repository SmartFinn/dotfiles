#!/usr/bin/env python3

"""
Created on Fri, 11 Aug 2017 05:41:46 +0300

@author: SmartfFinn
@documentation: https://github.com/hitbtc-com/hitbtc-api/blob/master/APIv2.md
"""

from requests.exceptions import ConnectionError, Timeout
import os
import requests


class HitBTCMarket:
    DEFAULT_BASE_URL = "https://api.hitbtc.com/api/2/"
    DEFAULT_TIMEOUT = 30

    def __init__(
        self,
        public_key=None,
        secret=None,
        base_url=DEFAULT_BASE_URL,
        request_timeout=DEFAULT_TIMEOUT,
    ):
        self.base_url = base_url
        self.request_timeout = request_timeout
        self.session = requests.session()

        if public_key and secret:
            self.session.auth = (public_key, secret)

    def _request(self, endpoint: str, params=""):
        response_object = self.session.get(
            self.base_url + endpoint, params=params, timeout=self.request_timeout
        )

        assert response_object.status_code == 200, "%s" % response_object.text

        try:
            response = response_object.json()
        except requests.exceptions.RequestException as e:
            return e

        return response

    def _pair(self, pair: str) -> str:
        return {
            "BTXUSD": "BTXUSDT",
            "LCCUSD": "LCCBTC",
            "ETHBNTUSD": "ETHBNTBTC",
            "USDUSD": "USDTUSD",
            "JSTUSD": "JSTUSDT",
            "XRPUSD": "XRPUSDT",
            "SBTCUSD": "SBTCUSDT",
            "EMCUSD": "EMCUSDT",
        }.get(pair.upper(), pair.upper())

    def get_tickers(self, *symbols) -> list:
        """Get tickers for all symbols or for specified symbols"""
        symbols = [self._pair(pair) for pair in symbols]
        response = self._request(
            "public/ticker/", params="symbols=" + ",".join(symbols)
        )

        return response

    @property
    def balance(self) -> list:
        """Returns the user's trading balance"""
        response = self._request("trading/balance")

        return response

    @property
    def own_currencies(self) -> list:
        """Returns currencies without zero balance"""
        return [
            i["currency"]
            for i in self.balance
            if float(i["available"]) > 0 or float(i["reserved"]) > 0
        ]


if __name__ == "__main__":
    primary_symbol = "BTCUSD"
    hide_currencies = ["ETHBNT", "LCC"]
    menu_open = os.getenv("ARGOS_MENU_OPEN")

    public_key = os.getenv("HITBTC_PUBLIC_KEY", None)
    secret_key = os.getenv("HITBTC_SECRET_KEY", None)

    hitbtc = HitBTCMarket(public_key=public_key, secret=secret_key, request_timeout=10)

    try:
        primary_ticker = hitbtc.get_tickers(primary_symbol)[0]
        print("${:.0f}".format(float(primary_ticker["last"])))
    except (ConnectionError, Timeout):
        print("No data")
    finally:
        print("---")

    if menu_open == "true":
        avail_currencies = hitbtc.own_currencies

        for currency in hide_currencies:
            avail_currencies.remove(currency)

        symbols = [currency + "USD" for currency in avail_currencies]

        tickers = hitbtc.get_tickers(*symbols)
        sorted_tickers = sorted(tickers, key=lambda k: k["symbol"])

        for ticker in sorted_tickers:
            symbol = ticker["symbol"]
            open_price = float(ticker["open"])
            last_price = float(ticker["last"])
            change_percent = (last_price - open_price) / open_price * 100

            if change_percent < 0:
                percent = "({0:.2f}%)".format(change_percent)
            elif change_percent == 0:
                percent = " ({0:.2f}%)".format(change_percent)
            else:
                percent = "(+{0:.2f}%)".format(change_percent)

            print(
                f"{symbol:10} {last_price:12.4f} {percent:10}",
                f"| font=monospace href=https://hitbtc.com/exchange/{symbol}",
            )
