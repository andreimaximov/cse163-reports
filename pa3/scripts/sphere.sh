#! /bin/bash

SCRIPTDIR=$(cd $(dirname ${0}) && pwd -P)

source ${SCRIPTDIR}/env.sh

${EXE} "${SCENES}/CornellBox-Sphere.obj" ${SCENES} "${CONFIG}/cornell-box-sphere.json"
