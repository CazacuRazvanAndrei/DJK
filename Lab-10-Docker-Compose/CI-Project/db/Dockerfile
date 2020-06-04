FROM postgres:12-alpine
COPY init-db.sql /docker-entrypoint-initdb.d/
ENV POSTGRES_USER cipass
ENV POSTGRES_PASSWORD dockerpass
ENV POSTGRES_DB pets