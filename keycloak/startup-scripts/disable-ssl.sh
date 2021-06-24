#!/bin/bash

export PATH=${HOME}/keycloak/bin/:$PATH

function configure_keycloak() {
  echo "Invoking kcadm.sh..."
  kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user "${KEYCLOAK_USER}" --password "${KEYCLOAK_PASSWORD}"
  kcadm.sh update realms/master -s sslRequired=none
}

(sleep 30 && configure_keycloak) &
