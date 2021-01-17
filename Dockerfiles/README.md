docker build -t eg_postgresql .
docker run --rm -P --name pg_test eg_postgresql
postgres_password=docker
postgres_username=docker


docker-compose down
docker rm -f $(docker ps -a -q)
docker volume rm $(docker volume ls -q)
docker-compose up -d



