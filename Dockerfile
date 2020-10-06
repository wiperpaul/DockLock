# Create new 
FROM ubuntu:20.04

LABEL "Description"="DockLock Hardened Container"
LABEL "Maintainer"="Paul Wiper"
LABEL "Version"="0.1" 

RUN echo "! WARNING MESSAGE !"
  echo "CONTAINER HAS KERNEL ACCESS, IF ANALYSING MALWARE USE WITHIN VM" \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  python 3 \
  # Downgrade to Non priv user
  adduser -D limited_user \
  

USER limited_user
WORKDIR /home/$USER/workdir
COPY internal_files.tar.gz $WORKDIR/imported_files





