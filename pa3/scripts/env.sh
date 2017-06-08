PADIR=$(dirname $(cd $(dirname ${0}) && pwd -P))

CONFIG="${PADIR}/config"

SCENES="${PADIR}/scenes"

CACHE="${PADIR}/.cache"

OS=$(uname)

# Specify OS here if can't auto-detect.
# OS="Darwin"

case $OS in
  "Linux")
    echo "Detected Linux..."
    EXE="${PADIR}/bin/pathtracer_linux_x64.bin"
    ;;
  "Darwin")
    echo "Detected macOS..."
    EXE="${PADIR}/bin/pathtracer_macos_x64.bin"
    ;;
  *)
    echo "Can't auto-detect OS. Please specify OS in ${PADIR}/scripts/env.sh."
    exit 1
esac
