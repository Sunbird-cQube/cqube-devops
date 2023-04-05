sudo docker exec -i  ansible_keycloak_app_1 sh << 'EOF'
/opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password admin

/opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=cQube -s enabled=true -o

/opt/jboss/keycloak/bin/kcadm.sh create clients -r cQube -s clientId=cqube-5.0 -s enabled=true -s clientAuthenticatorType=client-secret -s secret=d0b8122f-8dfb-46h7-b69a-f5cc4e25d000


EOF
