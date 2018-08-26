FROM alpine:3.8 as builder
LABEL maintainer="Georges Savoundararadj <savoundg@gmail.com>"
RUN apk update && apk add bash jq mysql mysql-client
ADD https://raw.githubusercontent.com/manoj23/mysql_install_db/v2.0.0/mysql_install_db.sh /usr/local/bin
RUN chmod +x /usr/local/bin/mysql_install_db.sh
ENTRYPOINT [ "/usr/local/bin/mysql_install_db.sh" ]
