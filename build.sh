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
  "ART-2.0.27.xar"
  "DECOR-core-2.0.23.xar"
  "DECOR-services-2.0.15.xar"
  "ART-DECOR-system-services-2.0.0.xar"
  "terminology-2.0.11.xar"
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