#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Dragon.obj" ${SCENES} "${CONFIG}/cornell-box-dragon.json"
