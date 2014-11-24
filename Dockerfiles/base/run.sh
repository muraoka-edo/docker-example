#!/bin/bash

docker run -p 2222:22 -d anduser01/base


result=$(docker ps | grep anduser01/base)
echo ""
echo ""
echo "======== Begin: Running Docker Container ==========="
echo " $result"
echo "========   End: Running Docker Container ==========="
echo ""
