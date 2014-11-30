#!/bin/bash
#-----------------------------------
# Global Variable
#-----------------------------------
readonly PRG_NAME=$0
readonly envfile='env_file'

# Export variables from...
. ${envfile}

#-----------------------------------
# Program Start!
#-----------------------------------
#if [ `whoami` != root ]; then
#    echo '[Error] You must be root to run'
#    exit 1
#fi

sed -e "s/%%os_user%%/${os_user}/g" ${tmpl} > Dockerfile
docker build -t "${docker_id}/${docker_attr}" .

result=$(docker images | grep "${docker_id}/${docker_attr}")

echo ""
echo ""
echo "======== Begin: Genarated Docker Image ==========="
echo " $result"
echo "========   End: Genarated Docker Image ==========="
echo ""

docker run -p 2222:22 -d -e HOST_NAME=${host_name} ${docker_id}/${docker_attr}

result=$(docker ps | grep ${docker_id}/${docker_attr})
echo ""
echo ""
echo "======== Begin: Running Docker Container ==========="
echo " $result"
echo "========   End: Running Docker Container ==========="
echo ""

rm -f Dockerfile

