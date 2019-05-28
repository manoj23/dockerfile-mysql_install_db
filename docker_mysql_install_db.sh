#!/usr/bin/env sh

set -e

main()
{
	if [ $# -ne 3 ]; then
		echo "$0 expects 3 arguments, Bye!"
		exit 1
	fi

	mysql_json_settings="$(realpath "$1")"
	mysql_db_path="$(realpath "$2")"
	sql_path="$(realpath "$3")"

	if [ ! -e "${mysql_json_settings}" ]; then
		echo "${mysql_json_settings} does not exist, Bye!"
		exit 1
	fi

	if [ ! -r "${mysql_json_settings}" ]; then
		echo "${mysql_json_settings} is not readable, Bye!"
		exit 1
	fi

	if [ ! -d "${mysql_db_path}" ]; then
		echo "${mysql_db_path} is not a folder, Bye!"
		exit 1
	fi

	if [ ! -e "${sql_path}" ]; then
		echo "${sql_path} does not exist, Bye!"
		exit 1
	fi

	if [ ! -r "${sql_path}" ]; then
		echo "${sql_path} is not readble, Bye!"
		exit 1
	fi

	# build docker image
	docker build \
		--build-arg UID="$(id -u)" \
		--build-arg GID="$(id -g)" \
		-t mysql_install_db \
		https://github.com:/manoj23/dockerfile-mysql_install_db.git

	# run docker image
	docker run --rm -ti \
		-v "${mysql_json_settings}":/home/mysqluser/settings.json \
		-v "${mysql_db_path}":/var/lib/mysql \
		mysql_install_db setup_db /home/mysqluser/settings.json /var/lib/mysql

	docker run --rm -ti \
		-v "${mysql_json_settings}":/home/mysqluser/settings.json \
		-v "${mysql_db_path}":/var/lib/mysql \
		-v "${sql_path}":/home/mysqluser/db.sql  \
		mysql_install_db import_db /home/mysqluser/settings.json /var/lib/mysql /home/mysqluser/db.sql
}

main "$@"
