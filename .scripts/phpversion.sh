#!/usr/bin/env bash

set -euo pipefail

error_message="You must specify a valid php version."

if [[ $# -eq 0 ]]; then
    echo "$error_message" >&2
    exit 1
fi

new_version="$1"

if [[ ! "$new_version" =~ ^8\.[0-9]$ ]]; then
    echo "$error_message php@${new_version} is not a valid php version" >&2
    exit 1
fi

current_version=$(php -v | sed -n 's/^PHP \([0-9]*\.[0-9]*\).*/\1/p')

if [[ "$current_version" == "$new_version" ]]; then
    echo "php version is already up to date"
    exit 0
fi

echo "current php version: php@${current_version}"

brew unlink "php@${current_version}"
echo "...unlinking php v${current_version}"

brew link "php@${new_version}"
echo "...linking php v${new_version}"

brew services restart php
echo "Service restarted successfully"