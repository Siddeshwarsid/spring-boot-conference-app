# Conference Demo app

## Build Docker images

```bash

docker-compose -f docker-compose/docker-compose-build.yaml build

```

Build specific service named `sql.data.client`

```bash

docker-compose -f docker-compose/docker-compose-build.yaml build sql.data.client

```