# keycloak

Run `docker-compose up -d`.

To access the admin console without SSL:

```
docker exec -it keycloak_keycloak_1 /bin/bash -c "./keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user keycloak --password keycloak && ./keycloak/bin/kcadm.sh update realms/master -s sslRequired=NONE"
```
