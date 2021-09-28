FROM mysql:5.7

ADD ./my-master.cnf /etc/mysql/my.cnf

RUN chmod 664 /etc/mysql/my.cnf

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]
