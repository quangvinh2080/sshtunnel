chmod 400 $KEY

mkdir -p ~/.ssh

echo "Host *" >> ~/.ssh/config
echo "    PubkeyAcceptedKeyTypes=+ssh-rsa" >> ~/.ssh/config
echo "    HostKeyAlgorithms=+ssh-rsa" >> ~/.ssh/config

if [ "$REMOTE" != "true" ]; then
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-L *:$LOCAL_PORT:$REMOTE_HOST:$REMOTE_PORT \
		-i $KEY
else
	ssh \
		-vv \
		-o StrictHostKeyChecking=no \
		-Nn $TUNNEL_HOST \
		-p $TUNNEL_PORT \
		-R 0.0.0.0:$REMOTE_PORT:$CONTAINER_HOST:$CONTAINER_PORT \
		-i $KEY
fi

