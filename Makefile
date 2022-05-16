psql-start:
	docker-compose --compatibility -f ./build/docker-compose.yml up

psql-stop:
	docker-compose --compatibility -f ./build/docker-compose.yml down