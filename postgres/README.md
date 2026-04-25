## postgresql

```bash
docker run --name my-postgres \
 -e POSTGRES_USER=test \
 -e POSTGRES_PASSWORD=123 \
 -p 5432:5432 \
 postgres
```

## pgadmin

```bash
docker run --name my-pgadmin \
  -p 5050:80 \
  -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com'  \
  -e 'PGADMIN_DEFAULT_PASSWORD=123'   \
  dpage/pgadmin4
```
