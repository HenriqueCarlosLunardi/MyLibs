#!/bin/sh
set -eu

if [ "$#" -gt 0 ]; then
    root="$1"
elif [ -d "Libraries" ]; then
    root="Libraries"
else
    root="/usr/share/nginx/html"
fi

if [ ! -d "$root" ]; then
    echo "Library root not found: $root" >&2
    echo "Usage: $0 [library-root]" >&2
    exit 1
fi

write_entries() {
    dir="$1"

    for child in "$dir"/*; do
        [ -d "$child" ] || continue
        basename "$child"
    done

    for child in "$dir"/*; do
        [ -f "$child" ] || continue
        [ "$(basename "$child")" != "index" ] || continue
        basename "$child"
    done
}

find "$root" -type d | sort | while IFS= read -r dir; do
    write_entries "$dir" | sort > "$dir/index"
done
