#magento docker

A basic image for magento images such as [jackie/magento]
Usage
Basic Example

Git clone and cd into it

Please copy magento files into this dir.

- magento/


```no-highlight
docker build -t=jackie/magento .
```
Need to link to another mysql container 

Please refer to https://github.com/jackie-yan/mysql-docker and to get running mysql container name 
by running

```no-highlight
docker ps
```
This mysql container will create magento database with sample data and magento user.

- Database Name: magento
- User Name: user
- User Password: password

Now, link magento app container to mysql container

```no-highlight
docker run -d --link jolly_poitras:db -p 80 jackie/magento 
```
Get IP address by docker inspect container_id

Browse: IP address. 

- eg: http://172.17.1.24


#Configuration

Complete the required information:

    Database Type: MySQL
    Host: db
    Database Name: magento
    User Name: user
    User Password: password
    Tables Prefix: (optional)




