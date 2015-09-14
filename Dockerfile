FROM ubuntu:14.10

RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get install -qq -y apt-transport-https


RUN echo deb http://apt.postgresql.org/pub/repos/apt/ utopic-pgdg main 9.5 > /etc/apt/sources.list.d/postgres.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 7FCC7D46ACCC4CF8

RUN apt-get update
RUN apt-get install -qq -y postgresql-9.5 \
                           postgresql-9.5-dbg \
                           postgresql-client-9.5 \
                           postgresql-server-dev-9.5 \
                           postgresql-doc-9.5 \
                           postgresql-contrib-9.5



##ADD postgresql.conf /etc/postgresql/9.5/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.5/main/pg_hba.conf
RUN chown postgres:postgres /etc/postgresql/9.5/main/*.conf

ADD pgrun.sh /usr/local/bin/pgrun.sh
RUN chmod +x /usr/local/bin/pgrun.sh

VOLUME ["/data"]
EXPOSE 5432
CMD ["/usr/local/bin/pgrun.sh"]
