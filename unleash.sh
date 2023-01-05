#!/bin/bash

## Usage:
## ./unleash.sh [options]
##
## Options:
##  -a, --action  [archive | create]  Action to be execute you can create ou archie a toggle list.
##  -t, --toggles [toggle_1 toggle_2] Specify a toggles list to be changed by action.
##  -h, --help    Prints help message.

display_usage() {
    sed -E -ne 's/^##(.*)/\1/p' $0
    exit 0
}

UNLEASH_API_URL="localhost"
UNLEASH_PORT=4242

while getopts t:a:h flag
do
    case "${flag}" in
        t) IFS=','
           feature_toggles=($OPTARG);;
        a) action=${OPTARG};;
        h) display_usage
    esac
done

create_toggles(){
  for feature_toggle in "${feature_toggles[@]}"
    do
       :
        curl --request POST "http://${UNLEASH_API_URL}:${UNLEASH_PORT}/api/admin/features" \
          --header 'Content-Type: application/json' \
          --data-raw '{
            "name": "'"${feature_toggle}"'",
            "description": "'"${feature_toggle}"' toggle.",
            "type": "release",
            "enabled": true,
            "stale": false,
            "strategies": [
              {
                "name": "default",
                "parameters": {}
              }
            ]
        }'
    done
}

if [ ! "$action" ] || [ ! "$feature_toggles" ]
then
  echo "Please select a valid action and toggles or type --help to show usage."
  display_usage
else
  create_toggles
  enabled_toggle
fi





