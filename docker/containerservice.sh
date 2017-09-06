sudo docker stop CASSANDRASERVICE
sudo docker rm CASSANDRASERVICE
sudo docker run -ti --name CASSANDRASERVICE -p 8081:8081 -v /vagrant/apps/healthylinkx-cassandra:/myapp --link CASSANDRA:CASSANDRA cassandraservice /bin/sh
