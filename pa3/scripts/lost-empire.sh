#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

DIR="${CACHE}/lost-empire"
ZIP="lost-empire.zip"
URL="http://graphics.cs.williams.edu/data/meshes/lost-empire.zip"
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

${EXE} "${DIR}/lost_empire.obj" ${DIR} "${CONFIG}/lost-empire.json"
