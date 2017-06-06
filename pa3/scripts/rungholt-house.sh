#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

DIR="${CACHE}/rungholt"
ZIP="rungholt.zip"
URL="http://graphics.cs.williams.edu/data/meshes/rungholt.zip"
CWD=$(pwd)

if [ ! -d ${DIR} ]; then
    echo "Downloading scene..."
    mkdir -p ${DIR}
    cd ${DIR}
    curl -o ${ZIP} ${URL}
    unzip ${ZIP}
    rm ${ZIP}
    cd ${CWD}
fi

${EXE} "${DIR}/house.obj" ${DIR} "${CONFIG}/rungholt-house.json"
