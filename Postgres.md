#Setup Postgres DB

## Create docker based Postgres

```bash

docker create --name postgres-demo -e POSTGRES_PASSWORD=Welcome -p 5432:5432 postgres:11.5-alpine

```

## Start Container

```bash

docker start postgres-demo

```

docker cp create_tables.sql postgres-demo:/create_tables.sql
docker exec -it postgres-demo psql -d conference_app -f create_tables.sql -U postgres


docker cp insert_data.sql postgres-demo:/insert_data.sql
docker exec -it postgres-demo psql -d conference_app -f insert_data.sql -U postgres

## Setup Postgres on Kubernetes

Run the install-postgresql.ps1 Powershell script which will install Postgres

Follow the instructions for connection

PostgreSQL can be accessed via port 5432 on the following DNS name from within your cluster:

    postgresql.default.svc.cluster.local - Read/Write connection

To get the password for "postgres" run:

    export POSTGRES_PASSWORD=$(kubectl get secret --namespace default postgresql -o jsonpath="{.data.postgresql-password}" | base64 --decode)

To connect to your database run the following command:

    kubectl run postgresql-client --rm --tty -i --restart='Never' --namespace default --image marketplace.azurecr.io/bitnami/postgresql:11.12.0-debian-10-r13 --env="PGPASSWORD=$POSTGRES_PASSWORD" --command -- psql --host postgresql -U postgres -d postgres -p 5432



To connect to your database from outside the cluster execute the following commands:

NOTE: It may take a few minutes for the LoadBalancer IP to be available.
Watch the status with: 'kubectl get svc --namespace default -w postgresql'

    export SERVICE_IP=$(kubectl get svc --namespace default postgresql --template "{{ range (index .status.loadBalancer.ingress 0) }}{{.}}{{ end }}")
    PGPASSWORD="$POSTGRES_PASSWORD" psql --host $SERVICE_IP --port 5432 -U postgres -d postgres
