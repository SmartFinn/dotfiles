#!/usr/bin/env python3

"""
Created on Thu, 15 Oct 2020 01:13:23 +0300

@author: SmartfFinn
@documentation: https://api.hitbtc.com/
"""

from requests.exceptions import ConnectionError, Timeout
from typing import Generator
from xdg import BaseDirectory
from pathlib import Path
import json
import os
import requests

APP_NAME: str = "crypto-price"
CONFIG_DIR: Path = Path(BaseDirectory.xdg_config_home, APP_NAME)
CONFIG_FILE: Path = CONFIG_DIR / f"{APP_NAME}.json"

DEFAULT_CONFIG: dict = {
    "main_symbol": "BTC-USDT",
    "symbols": ["BTC-USDT", "ETH-USDT", "ETH-BTC"],
}


class Ticker(object):
    def __init__(self, symbol, ticker):
        self.symbol: str = symbol
        self.last: str = ticker.get("last")
        self.low: str = ticker.get("low")
        self.high: str = ticker.get("high")
        self.open: str = ticker.get("open")
        self.change: str = "{:.2f}".format(
            (float(self.last) - float(self.open)) / float(self.open) * 100
        )

    def __repr__(self) -> str:
        return "{} {}".format(self.__class__.__name__, self.__dict__)


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

    def _request(self, endpoint: str, params: str = "") -> dict[str, str]:
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
        """
        Retrieves data for the specified symbol.

        Args:
            symbol (str): The symbol for which to retrieve ticker information.

        Returns:
            dict: A dictionary containing the following structure:
                {
                    "low": str,      # The lowest value of the symbol.
                    "high": str,     # The highest value of the symbol.
                    "last": str,     # The last recorded value of the symbol.
                    "change": str    # The change in value of the symbol.
                }
        """
        _symbol: str = symbol.replace("-", "")
        return Ticker(_symbol, self._request("public/ticker/" + _symbol))

    def get_tickers(self, *symbols: list[str]) -> Generator[Ticker, None, None]:
        """Get tickers for all symbols or for specified symbols

        Args:
            *symbols (list): list of symbol codes

        Yields:
            Ticker: ticker for each symbol
        """
        _symbols: list[str] = [symbol.replace("-", "") for symbol in symbols]
        symbols_map: dict[str, str] = {y: x for x, y in zip(symbols, _symbols)}

        tickers: dict[str, dict[str, str]] = self._request(
            "public/ticker/", params="symbols=" + ",".join(_symbols)
        )

        for symbol, ticker in tickers.items():
            yield Ticker(symbols_map[symbol], ticker)

    @staticmethod
    def get_link(pair: str) -> str:
        """
        Get link the symbol on HitBTC

        Args:
            pair (str): The symbol for which get the link

        Returns:
            str: URL to the pair on the exchange
        """
        _pair: str = pair.replace("-", "-to-")
        return f"https://hitbtc.com/{_pair.lower()}"


if __name__ == "__main__":
    menu_open: str = os.getenv("ARGOS_MENU_OPEN")

    if CONFIG_FILE.exists():
        with CONFIG_FILE.open("r") as f:
            config: dict = json.load(f)
    else:
        CONFIG_DIR.mkdir(parents=True, exist_ok=True)
        with CONFIG_FILE.open("w") as f:
            json.dump(DEFAULT_CONFIG, f, indent=4)
        config: dict = DEFAULT_CONFIG

    main_symbol: str = config["main_symbol"]
    symbols: list[str] = config["symbols"]

    exchange = HitBTCMarket(request_timeout=10)

    try:
        main_ticker_data = exchange.get_ticker(main_symbol)
        print("${:.0f}".format(float(main_ticker_data.last)))
    except (ConnectionError, Timeout):
        print("No data")
    finally:
        print("---")

    if menu_open == "true":
        tickers = exchange.get_tickers(*symbols)

        for ticker in tickers:
            ticker_link = exchange.get_link(ticker.symbol)
            percent = "{:>5}%".format(ticker.change) if float(
                ticker.change) <= 0 else "+{:4}%".format(ticker.change)

            print(
                f"{ticker.symbol:10} {ticker.last:12}",
                f"⭳ {ticker.low:12} ⭱ {ticker.high:12} ({percent})",
                f"| font=monospace href={ticker_link}",
            )
