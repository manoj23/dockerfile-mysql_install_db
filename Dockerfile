FROM alpine:3.8 as builder
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
ARG UID=${UID:-1000}
ARG GID=${GID:-1000}
RUN apk update && apk add bash jq mysql mysql-client
ADD https://raw.githubusercontent.com/manoj23/mysql_install_db/v2.0.0/mysql_install_db.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mysql_install_db.sh
RUN echo "mysql:x:${GID}:mysql" > /etc/group && echo "mysql:x:${UID}:${GID}:mysql:/var/lib/mysql:/sbin/nologin" > /etc/passwd
ENTRYPOINT [ "/usr/local/bin/mysql_install_db.sh" ]
