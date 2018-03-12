#!/bin/sh

# Cache eXist-db locally
if [ ! -f ./assets/eXist-db-setup-2.2-rev0000.jar ]; then
    echo "Downloading eXist-db"
    wget -P ./assets http://downloads.sourceforge.net/project/artdecor/eXist-db/eXist-db-setup-2.2-rev0000.jar
fi


# Base URL for downloading exist packages with ART-DECOR
BASE_URL="http://decor.nictiz.nl/apps/public-repo/public/"

# Order is important!
PACKAGES=(
  "ART-1.8.58.xar"
  "DECOR-core-1.8.42.xar"
  "DECOR-services-1.8.35.xar"
  "ART-DECOR-system-services-1.8.23.xar"
  "terminology-1.8.36.xar"
)
    
for i in "${PACKAGES[@]}"
do
    if [ ! -f ./assets/exist-packages/$i ]; then
        echo "Downloading package $i"
        wget -P ./assets/exist-packages $BASE_URL$i
    fi
done
    

# Cache art-decor locally
if [ ! -f ./assets/art-decor.war ]; then
    echo "Downloading ART-DECOR"
    wget -P ./assets http://downloads.sourceforge.net/project/artdecor/Orbeon/art-decor.war
fi

# Build the docker!
docker build -t art-decor-base -f Dockerfile.base .
docker build -t art-decor .