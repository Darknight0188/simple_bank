DB_URL=postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable

postgres:
	docker run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine
mysql:
	docker run --name mysql8 -p 3307:3306  -e MYSQL_ROOT_PASSWORD=secret -d mysql:8
createdb:
	docker exec -it postgres createdb --username=root --owner=root simple_bank
dropdb:
	docker exec -it postgres dropdb simple_bank
migrateup:
	migrate -path db/migrations -database "$(DB_URL)" -verbose up
migratedown:
	migrate -path db/migrations -database "$(DB_URL)" -verbose down
sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc mysql