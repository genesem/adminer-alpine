
# adminer-alpine

Adminer +  ~~Editor~~ on Alpine, super small and fast.

- Git: https://github.com/genesem/adminer-alpine
- Docker: https://hub.docker.com/r/genesem/adminer-alpine

"Official" image is cool but <b>5x bigger</b>.

i.e. official "adminer" image takes 250Gi when installed,
this image takes only 49Gi.

---

Custom desgin used: *lucas-sandery*.

Plugins built-in: 
* tables-filter 
* wymeditor 
* dump-json 
* dump-date


Example docker compose file in two containers: PostgreSQL and adminer-alpine.

file `docker-compose.yml`:
```
name: pgsql_16
services:
  db:
    container_name: pg16
    image: postgres:16-alpine
    restart: on-failure:3
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=postgres
    volumes:
      - ./pgdata:/var/lib/postgresql/data
    ports:
      - '5432:5432'
    networks:
      - postgres

  adminer:
    container_name: myAdminer
    image: genesem/adminer-alpine
    restart: on-failure:3
    ports:
      - 8080:8080
    networks:
      - postgres

networks:
   postgres:
     driver: bridge
```
Start it with command: 
`mkdir -p pgdata && docker-compose up -d`

Open in browser: http://localhost:8080  connect to pgsql with:
 - server: db
 - user: postgres
 - password: postgres 
