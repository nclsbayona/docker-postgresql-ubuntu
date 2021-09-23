FROM ubuntu
RUN apt-get update && apt-get install -y -q wget lsb-release gnupg
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Bogota
RUN apt-get update && apt-get install -y postgresql
USER root
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/$(ls /etc/postgresql)/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/$(ls /etc/postgresql)/main/postgresql.conf
EXPOSE 5432
RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
ENV PASS=here_comes_password_for_user
ENV BBDD=here_comes_bd_name 
ENV USER=here_comes_user
ADD entrypoint.sh /usr/local/bin 
RUN chmod +x /usr/local/bin/entrypoint.sh
USER postgres
CMD /usr/local/bin/entrypoint.sh