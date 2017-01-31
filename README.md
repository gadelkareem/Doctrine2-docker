Doctrine2-docker
================

Docker containers for Doctrine2 Testsuite


- run `docker-composer build` to build containers
- run `docker-composer up` to start containers
- run `docker exec -it doctrine2docker_doctrine_1 /bin/bash` to login the Doctrine container
- run `./vendor/phpunit/phpunit/phpunit  tests` to run the unit Testsuite
- run alias `dtests` or `./vendor/phpunit/phpunit/phpunit -c /var/mysql.docker.xml ` to run the Functional Testsuite against MySQL

#Testing Lock-Support
- use `nohup php Doctrine/Tests/ORM/Functional/Locking/LockAgentWorker.php &` to start servers and `./vendor/phpunit/phpunit/phpunit  tests/Doctrine/Tests/ORM/Functional/Locking/GearmanLockTest.php` to test Lock-Support


