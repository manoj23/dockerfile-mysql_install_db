dockerfile-mysql_install_db
===========================

This is a simple alpine container that runs the mysql_install_db.sh script.

## Example of docker build

```
docker build -t mysql_install_db https://github.com:/manoj23/dockerfile-mysql_install_db.git
```

## Example of docker run


Run the following command to initialize the data directory:
```
$ mkdir -p /path/to/db/
$ docker run --rm -ti \
	-v $(pwd)/example.json:/root/example.json \
	-v /path/to/db/:/var/lib/mysql \
	mysql_install_db /root/example.json /var/lib/mysql
```
