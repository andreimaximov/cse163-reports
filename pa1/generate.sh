#! /bin/bash

BASE=$(dirname "$0")
S3="https://s3.amazonaws.com/andrei-maximov-public/ucsd/cse163/pa1"

sed -e 's|${s3}|'${S3}'|g' "${BASE}/src/README.md" > "${BASE}/README.md"