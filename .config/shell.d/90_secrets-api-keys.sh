command -v pass >/dev/null || return 0
test -f "$HOME/.config/environment.d/050_secrets_api_keys.conf" && return 0

GITHUB_TOKEN="$(pass show api/github/token)"
OPENROUTER_API_KEY="$(pass show api/openrouter/api_key)"
GEMINI_API_KEY="$(pass show api/gemini/api_key)"

cat > "$HOME/.config/environment.d/050_secrets_api_keys.conf" <<EOF
GITHUB_TOKEN="$GITHUB_TOKEN"
GH_TOKEN="$GITHUB_TOKEN"
GHI_TOKEN="$GITHUB_TOKEN"
PET_GITHUB_ACCESS_TOKEN="$GITHUB_TOKEN"
THE_WAY_GITHUB_TOKEN="$GITHUB_TOKEN"

HITBTC_PUBLIC_KEY="$(pass show api/hitbtc/public_key)"
HITBTC_SECRET_KEY="$(pass show api/hitbtc/secret_key)"

WHITEBIT_PUBLIC_KEY="$(pass show api/whitebit/api_key)"
WHITEBIT_SECRET_KEY="$(pass show api/whitebit/api_secret)"

OKX_PUBLIC_KEY="$(pass show api/okx/api_key)"
OKX_SECRET_KEY="$(pass show api/okx/api_secret)"
OKX_PASSPHRASE="$(pass show api/okx/api_passphrase)"

BYBIT_PUBLIC_KEY="$(pass show api/bybit/api_key)"
BYBIT_SECRET_KEY="$(pass show api/bybit/api_secret)"

BINGX_PUBLIC_KEY="$(pass show api/bingx/api_key)"
BINGX_SECRET_KEY="$(pass show api/bingx/api_secret)"

MEXC_PUBLIC_KEY="$(pass show api/mexc/api_key)"
MEXC_SECRET_KEY="$(pass show api/mexc/api_secret)"

BITGET_PUBLIC_KEY="$(pass show api/bitget/api_key)"
BITGET_SECRET_KEY="$(pass show api/bitget/api_secret)"

TINYPNG_API_KEY="$(pass show api/tinypng/api_key)"

YOUTUBE_API_KEY="$(pass show api/youtube/api_key)"
YOUTUBE_CHANNEL_ID="$(pass show api/youtube/channel_id)"

OPENAI_API_KEY="$(pass show api/openai/api_key)"
OPENROUTER_API_KEY="$OPENROUTER_API_KEY"
LLM_KEY="$OPENROUTER_API_KEY"
GEMINI_API_KEY="$GEMINI_API_KEY"
GOOGLE_GENERATIVE_AI_API_KEY="$GEMINI_API_KEY"
EOF
