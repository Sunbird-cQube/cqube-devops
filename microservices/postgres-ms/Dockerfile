FROM postgres
COPY V1__create_tabel.sql /docker-entrypoint-initdb.d/V1__create_tabel.sql

RUN rm -rf /var/lib/postgresql/data/postgresql.conf

COPY postgresql.conf /var/lib/postgresql/data/postgresql.conf
