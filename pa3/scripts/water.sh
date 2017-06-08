#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Water.obj" ${SCENES} "${CONFIG}/cornell-box-water.json"
