#!/bin/sh
printf '\033c\033]0;%s\a' SAdasdasd
base_path="$(dirname "$(realpath "$0")")"
"$base_path/durka" "$@"
