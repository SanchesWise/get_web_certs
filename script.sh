#!/bin/bash

hosts=("$@")
for host in "${hosts[@]}"; do
	echo | openssl s_client -showcerts -servername $host -connect $host:443 2>/dev/null | openssl x509 -text > $host.crt
	keytool -import -trustcacerts -alias $host -file $host.crt -keystore /etc/ssl/certs/java/cacerts -storepass changeit -noprompt
	cp $host.crt /usr/local/share/ca-certificates/
done
update-ca-certificates
