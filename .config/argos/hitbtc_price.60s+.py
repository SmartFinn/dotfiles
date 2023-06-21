#!/usr/bin/env python3

"""
Created on Thu, 15 Oct 2020 01:13:23 +0300

@author: SmartfFinn
@documentation: https://api.hitbtc.com/
"""

from requests.exceptions import ConnectionError, Timeout
from typing import Any
import os
import requests


class HitBTCMarket:
    DEFAULT_BASE_URL = "https://api.hitbtc.com/api/3/"
    DEFAULT_TIMEOUT = 30

    def __init__(
        self,
        public_key=None,
        secret=None,
        base_url=DEFAULT_BASE_URL,
        request_timeout=DEFAULT_TIMEOUT,
    ) -> None:
        self.base_url = base_url
        self.request_timeout = request_timeout
        self.session = requests.session()

        if public_key and secret:
            self.session.auth = (public_key, secret)

    def _request(self, endpoint: str, params: str = "") -> Any:
        response_object = self.session.get(
            self.base_url + endpoint, params=params, timeout=self.request_timeout
        )

        assert response_object.status_code == 200, "%s" % response_object.text

        try:
            response = response_object.json()
        except requests.exceptions.RequestException as e:
            raise e

        return response

    def get_ticker(self, symbol: str) -> dict[str, str]:
        """Get ticker by symbol"""
        return self._request("public/ticker/" + symbol)

    def get_tickers(self, *symbols: str) -> dict[str, dict]:
        """Get tickers for all symbols or for specified symbols"""
        return self._request(
            "public/ticker/", params="symbols=" + ",".join(symbols)
        )

    @property
    def trading_balance(self) -> list[dict]:
        """Returns the spot trading balance"""
        return self._request("spot/balance")

    @property
    def available_currencies(self) -> list[str]:
        """Returns the available currencies on the trading balance"""

        return [item['currency'] for item in self.trading_balance]


if __name__ == "__main__":
    primary_symbol = "BTCUSDT"
    menu_open = os.getenv("ARGOS_MENU_OPEN")

    public_key = os.getenv("HITBTC_PUBLIC_KEY", None)
    secret_key = os.getenv("HITBTC_SECRET_KEY", None)

    hitbtc = HitBTCMarket(public_key=public_key,
                          secret=secret_key, request_timeout=10)

    try:
        primary_ticker = hitbtc.get_ticker(primary_symbol)
        print("${:.0f}".format(float(primary_ticker["last"])))
    except (ConnectionError, Timeout):
        print("No data")
    finally:
        print("---")

    if menu_open == "true":
        symbols = [currency + "USDT" for currency in hitbtc.available_currencies]
        tickers = hitbtc.get_tickers(*symbols)

        for symbol, ticker in tickers.items():
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
                f"| font=monospace href=https://hitbtc.com/{symbol[:-4]}-to-USDT",
            )
