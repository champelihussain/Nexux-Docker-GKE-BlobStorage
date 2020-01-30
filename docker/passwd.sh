#!/bin/bash

sleep 90
echo ">>>>  Before Password Change <<<<"
# use while loop to check if service is running 
while true
do
    netstat -uplnt | grep :8081 | grep LISTEN > /dev/null
    verifier=$?
    if [ 0 = $verifier ]
        then
            echo "Service Running, initialization"
                pwd="$(cat /nexus-data/admin.password)"
                curl http://localhost:8081/

                echo $pwd
                curl -u admin:$pwd -X PUT "http://localhost:8081/service/rest/beta/security/users/admin/change-password" -H "accept: application/json" -H "Content-Type: text/plain" -d "admin123$"
            break
        else
            echo "Service is not running yet"
            sleep 5
    fi
done