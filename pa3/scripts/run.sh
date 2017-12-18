#!/bin/bash

if [ ! -f ./.cache/ok ]; then
    ./scripts/download.sh
fi

OS=$(uname)

case $OS in
  "Linux")
    echo "Detected Linux..."
    ./bin/pathtracer_linux_x64.bin $1 $2 $3
    ;;
  "Darwin")
    echo "Detected macOS..."
    ./bin/pathtracer_macos_x64.bin $1 $2 $3
    ;;
  *)
    echo "Can't auto-detect OS. "
    exit 1
esac

