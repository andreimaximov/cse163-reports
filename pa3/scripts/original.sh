#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Original.obj" ${SCENES} "${CONFIG}/cornell-box-original.json"
