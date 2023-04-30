# start with Alpine Linux
FROM alpine:3.7
MAINTAINER Christian Becker <mail@christianbecker.name>

# system setup with "bash", "openssh-client" and "tmux"
RUN apk add --no-cache \
        bash \
        openssh-client \
        tmux \
    && echo "! installation is finished !" \
    && wget -O /ssh-multiplex-legacy https://raw.githubusercontent.com/christian-becker/ssh-multiplex/main/ssh-multiplex \
    && sed -i 's/SSHCMD=.*/SSHCMD="ssh -oCiphers=+3des-cbc -oHostKeyAlgorithms=+ssh-dss -oKexAlgorithms=+diffie-hellman
-group1-sha1 -oUserKnownHostsFile=\/dev\/null -oStrictHostKeyChecking=no -oLogLevel=error _DESTINATION_ ; read -n 1 -p \"Connection to _DESTINATION_ - Press any key to close...\""/' /ssh-multiplex-legacy \
    && echo "ssh-multiplex script downloaded and modified with ssh legacy options - ready to use" \

# run openssh-client
ENTRYPOINT ["/usr/bin/env bash", "/ssh-multiplex-legacy"]
