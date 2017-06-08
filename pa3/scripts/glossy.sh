#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Glossy.obj" ${SCENES} "${CONFIG}/cornell-box-glossy.json"