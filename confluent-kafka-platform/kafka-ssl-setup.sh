#!/bin/sh

set -e

rm -rfv secrets/ *.jks *.key *.csr *.crt *.srl *.p12 *.pem *.pw
mkdir -p secrets/

ca_pass=kafkaca
trust_storepass=kafkatrust
broker_hostname=localhost
broker_keypass=kafkabroker
broker_storepass=${broker_keypass} # need to be the same
client_keypass=kafkaclient
client_storepass=kafkaclient
schema_hostname=${broker_hostname}
schema_keypass=kafkaschema
schema_storepass=kafkaschema

# create root CA
openssl req -batch -new -x509 -passout pass:${ca_pass} -keyout kafka-ca.key -out kafka-ca.crt -days 1095 -subj '/C=DE/ST=Baden-Wuerttemberg/O=unmacaque Kafka Co/CN=Kafka Root CA/'

# create global trust store for broker and clients
openssl pkcs12 -export -nokeys -in kafka-ca.crt -out kafka-trust.p12 -passout pass:${trust_storepass}
keytool -import -noprompt -file kafka-ca.crt -keystore secrets/kafka-trust.jks -storepass ${trust_storepass}
keytool -importkeystore -destkeystore secrets/kafka-trust.jks -deststorepass ${trust_storepass} -srckeystore kafka-trust.p12 -srcstoretype PKCS12 -srcstorepass ${trust_storepass}

# create broker key and signed certificate
openssl req -batch -new -passout pass:${broker_keypass} -keyout kafka-broker.key -out kafka-broker.csr -subj "/C=DE/ST=Baden-Wuerttemberg/O=unmacaque Kafka Co/CN=${broker_hostname}/"
openssl x509 -req -CA kafka-ca.crt -CAkey kafka-ca.key -CAcreateserial -days 1095 -passin pass:${ca_pass} -in kafka-broker.csr -out kafka-broker.crt

# create broker key store
openssl pkcs12 -export -in kafka-broker.crt -inkey kafka-broker.key -out kafka-broker.p12 -name "Kafka Broker" -passin pass:${broker_keypass} -passout pass:${broker_storepass}
# convert to JKS
keytool -import -noprompt -file kafka-broker.crt -keystore secrets/kafka-broker.jks -storepass ${broker_storepass}
keytool -importkeystore -destkeystore secrets/kafka-broker.jks -deststorepass ${broker_storepass} -srckeystore kafka-broker.p12 -srcstoretype PKCS12 -srcstorepass ${broker_storepass}

# create schema registry key and signed certificate
openssl req -batch -new -passout pass:${schema_keypass} -keyout kafka-schema.key -out kafka-schema.csr -subj "/C=DE/ST=Baden-Wuerttemberg/O=unmacaque Kafka Co/CN=${schema_hostname}/"
openssl x509 -req -CA kafka-ca.crt -CAkey kafka-ca.key -CAcreateserial -days 1095 -passin pass:${ca_pass} -in kafka-schema.csr -out kafka-schema.crt

# create schema registry key store
openssl pkcs12 -export -in kafka-schema.crt -inkey kafka-schema.key -out kafka-schema.p12 -name "Kafka Schema Registry" -passin pass:${schema_keypass} -passout pass:${schema_storepass}
# convert to JKS
keytool -import -noprompt -file kafka-schema.crt -keystore secrets/kafka-schema.jks -storepass ${schema_storepass}
keytool -importkeystore -destkeystore secrets/kafka-schema.jks -deststorepass ${schema_storepass} -srckeystore kafka-schema.p12 -srcstoretype PKCS12 -srcstorepass ${schema_storepass}

# kafka docker images want the credentials saved in a file
echo ${broker_storepass} > secrets/kafka-broker-store.pw
echo ${broker_keypass} > secrets/kafka-broker-key.pw
echo ${trust_storepass} > secrets/kafka-trust-store.pw

# create client key and signed certificate
openssl req -batch -new -passout pass:${client_keypass} -keyout kafka-client.key -out kafka-client.csr -subj '/C=DE/ST=Baden-Wuerttemberg/O=unmacaque Kafka Co/CN=kafka-client/'
openssl x509 -req -CA kafka-ca.crt -CAkey kafka-ca.key -CAcreateserial -days 1095 -passin pass:${ca_pass} -in kafka-client.csr -out kafka-client.crt

# create client keystore
openssl pkcs12 -export -in kafka-client.crt -inkey kafka-client.key -out kafka-client.p12 -name "Kafka Client" -passin pass:${client_keypass} -passout pass:${client_storepass}
# convert to JKS
keytool -import -noprompt -file kafka-client.crt -keystore secrets/kafka-client.jks -storepass ${client_storepass}
keytool -importkeystore -destkeystore kafka-client.jks -deststorepass ${client_storepass} -srckeystore kafka-client.p12 -srcstoretype PKCS12 -srcstorepass ${client_storepass}
