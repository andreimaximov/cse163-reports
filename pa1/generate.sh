#!/bin/bash

HOST="images"

sed -e 's|${host}|'${HOST}'|g' "./src/README.md" > "./README.md"
