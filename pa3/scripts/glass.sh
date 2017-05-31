#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Glass.obj" ${SCENES} "${CONFIG}/cornell-box-glass.json"
