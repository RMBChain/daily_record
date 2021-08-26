
sed -i -e 's/\r$//'  *.sh

docker-compose up

docker-compose down

docker run -it --rm --net container:77dae95597aa busybox sh

docker exec -it master-slave_redis-slave_1 redis-cli

docker exec -it master-slave_redis-master_1 redis-cli


docker-compose up --scale webapp=3