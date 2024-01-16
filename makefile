runcontainer:
	docker run --name postgres16 -p 5433:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 -d postgres:16-alpine

removecontainer:
	docker rm -f postgres16

createdb:
	docker exec -it postgres16 createdb -U postgres simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

migrationup:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5433/simple_bank?sslmode=disable" -verbose up

migrationdown:
	migrate -path db/migration -database "postgresql://postgres:123456@localhost:5433/simple_bank?sslmode=disable" -verbose down 

sqlc:
	sqlc generate

.PHONY: runcontainer removecontainer createdb dropdb migrationup migrationdown sqlc
