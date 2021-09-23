/etc/init.d/postgresql start;
psql --command "CREATE USER ${USER} WITH SUPERUSER PASSWORD '${PASS}';"; 
eval "createdb -O $USER ${BBDD}";
/etc/init.d/postgresql stop;
exec /usr/lib/postgresql/$(ls /etc/postgresql)/bin/postgres -D /var/lib/postgresql/$(ls /etc/postgresql)/main -c config_file=/etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf;