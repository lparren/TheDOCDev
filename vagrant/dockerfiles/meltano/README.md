### Commando's

docker compose up db
docker compose up pgadmin

docker compose run --rm  dbt seed
docker compose run --rm  dbt test
docker compose run --rm  dbt run
docker compose run --rm  dbt debug

docker compose run --rm  dbt docs generate
docker compose run --rm -d --service-ports dbt docs serve


