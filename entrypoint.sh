#!/bin/bash
set -m

echo ""
echo "-------------- Starting MySql server ------------------"
echo ""
find /var/lib/mysql -type f -exec touch {} \; && service mysql start
service apache2 start

echo ""
echo "----------------- Starting MongoDB --------------------"
echo ""
/temp/mongostart.sh
mongo -u admin -p 'adminroot' --authenticationDatabase admin admin --eval "db.grantRolesToUser('admin',[{ role: \"root\", db: \"admin\" }])"
mongo -u admin -p 'adminroot' --authenticationDatabase admin admin --eval "db = db.getSiblingDB('restaurants');"
mongo -u admin -p 'adminroot' --authenticationDatabase admin restaurants --eval "load('/temp/restaurants.mongo');"
mongo -u admin -p 'adminroot' --authenticationDatabase admin admin --eval "db = db.getSiblingDB('wine');"
mongo -u admin -p 'adminroot' --authenticationDatabase admin wine --eval "load('/temp/wine.mongo');"
cd /var/lib/adminMongo
node app > /dev/null &

echo ""
echo "------------------ Starting Neo4j ---------------------"
echo ""
mkdir /var/run/neo4j
neo4j start

echo ""
echo "----------------- Starting jupyter --------------------"
echo ""
cd /home
nohup jupyter notebook > /dev/null &
sleep 2

echo ""
echo ""
echo "/--------- CS1565 development environment ------------\\"
echo "|          To access the web services open            |"
echo "|                 http://localhost                    |"
echo "|               on your local browser                 |"
echo "|                                                     |"
echo "|        Your workspace directory is on /home         |"
echo "\\-----------------------------------------------------/"
echo ""
bash


