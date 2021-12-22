#!/bin/bash
DOWNLOAD_URL="https://studium.hs-ulm.de/de/org/I/pruefungen/Downloads/Pr%C3%BCfungsplan_INF.pdf"
FILE="Prüfungsplan_INF.pdf"
CKSUM_FILE=.cksum.txt

wget -O $FILE $DOWNLOAD_URL

CKSUM=$(cksum $FILE)

if [ -f "$CKSUM_FILE" ]; then
    CKSUM_OLD=$(cat $CKSUM_FILE)
    if [ "$CKSUM_OLD" = "$CKSUM" ]; then
        CHANGE=0
    else
        CHANGE=1
    fi
else
    CHANGE=1
fi

echo $CKSUM > $CKSUM_FILE

if (( $CHANGE == 1 )); then
    echo New File available!

    TIMESTAMP=$(date -u +%FT%TZ)
    WEBHOOK_DATA='{
        "username": "Prüfungsplan Updates",
        "avatar_url": "https://i.imgur.com/1sSnXQn.png",
        "embeds": [ {
            "title": "'"$FILE"'",
            "description": "Eine neue Version des Prüfungsplans ist verfügbar!",
            "url": "'"$DOWNLOAD_URL"'",
            "color": 21923,
            "timestamp": "'"$TIMESTAMP"'",
            "thumbnail": {
                "url": "https://i.imgur.com/9RQYLfB.png"
            }
        } ]
    }'

    echo $WEBHOOK_DATA

    (curl --fail --progress-bar -A "Webhook" -H Content-Type:application/json -H X-Author:ungefroren#2222 -d "${WEBHOOK_DATA//	/ }" "$WEBHOOK_URL" \
        && echo -e "[Webhook]: Successfully sent the webhook.") || (echo -e "[Webhook]: Unable to send webhook." ; exit 1)
else
    echo No change!
fi