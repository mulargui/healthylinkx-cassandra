sudo docker stop CQLSH
sudo docker rm -f CQLSH
#sudo docker run -ti --link some-cassandra:cassandra --rm cassandra cqlsh cassandra
#sudo docker run -ti --name CQLSH --link CASSANDRA:CASSANDRA -v /vagrant/apps/healthylinkx-cassandra:/myapp --rm cassandra cqlsh cassandra
sudo docker run -ti --name CQLSH --link CASSANDRA:CASSANDRA -v /vagrant/apps/healthylinkx-cassandra:/myapp --rm cassandra /bin/bash