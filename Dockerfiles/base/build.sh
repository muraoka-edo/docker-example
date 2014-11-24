#!/bin/bash

#-----------------------------------
# Global Variable
#-----------------------------------
readonly PRG_NAME=$0
readonly TMPL='Dockerfile.tmpl'
readonly DOCKER_FILE='Dockerfile'
readonly DOCKER_ID='dmuraoka'
LOGIN_USER=''

#-----------------------------------
# Program Start!
#-----------------------------------
if [ "$1" ]; then
    LOGIN_USER=$1
else
    echo "[Error] This program explains the set args command."
    echo "  like this: $0 <login user>"
    exit 1
fi

#if [ `whoami` != root ]; then
#    echo '[Error] You must be root to run'
#    exit 1
#fi

sed -e "s/%%LOGIN_USER%%/${LOGIN_USER}/g" ${TMPL} > ${DOCKER_FILE}

docker build -t ${DOCKER_ID}/base .

result=$(docker images | grep "${DOCKER_ID}/base")

echo ""
echo ""
echo "======== Begin: Genarated Docker Image ==========="
echo " $result"
echo "========   End: Genarated Docker Image ==========="
echo ""

rm -f ${DOCKER_FILE}
