#! /bin/bash

BASE=$(dirname "$0")
HOST="http://andreimaximov.com/files/projects/cse163-reports/pa1"

sed -e 's|${host}|'${HOST}'|g' "${BASE}/src/README.md" > "${BASE}/README.md"