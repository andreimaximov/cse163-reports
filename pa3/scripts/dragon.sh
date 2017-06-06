#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

OBJ="${SCENES}/CornellBox-Dragon.obj"
URL="https://s3.amazonaws.com/andrei-maximov-public/ucsd/cse163/pa3/scenes/CornellBox-Dragon.obj"

if [ ! -f ${OBJ} ]; then
    echo "Downloading OBJ file..."
    curl -o ${OBJ} ${URL}
fi

${EXE} ${OBJ} ${SCENES} "${CONFIG}/cornell-box-dragon.json"
