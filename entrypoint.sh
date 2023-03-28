#!/bin/sh -l

REPO="$1"
ENDPOINT="$2"
KEY="$3"

#clone and build
rm -rf app
git clone "$REPO" "app"
cd app
npm i
npm run test
npm run build

# zip
cd dist
zip -r ../../deploy.zip *

# deploy
cd ../../
curl -H "X-API-Key: $KEY" "$ENDPOINT" -F file=@deploy.zip