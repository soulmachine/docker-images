Official mysql docker image with addtional configurations:

* Use `utf8mb4` to enable full unicode support
* UTC timezone


Document is the same as the official <https://hub.docker.com/_/mysql/>


## How to use this image ?

Start a mysql server instance:

    docker run --name some-mysql -v /my/own/datadir:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -p 3306:3306 -d soulmachine/mysql

where `some-mysql` is the name you want to assign to your container, `/my/own/datadir` is a data directory on your host system, `my-secret-pw` is the password to be set for the MySQL root user.
