#!/bin/bash

TEST_STATUS=0
# Check if args was given
if [ $# -eq 0 ]; then
  APP_URL="localhost:8081"
else
  APP_URL=$1
fi


urls_status_code=("http://${APP_URL}"
                  "http://${APP_URL}/api/search?q=happy")
                  
for url in "${urls_status_code[@]}"
do
    response_code=$(curl -s -o /dev/null -w "%{http_code}" http://${APP_URL}/api/search?q=happy)
    if [ "$response_code" -eq 200 ]; then
      echo "URL http://${APP_URL} is up and running."
    else
      echo "URL http://${APP_URL} is down. Response code: $response_code"
      TEST_STATUS=1
    fi
done

echo $TEST_STATUS
exit $TEST_STATUS

# urls=( "http://${APP_URL}/api/summary?url=https://www.ted.com/talks/kwabena_boahen_on_a_computer_that_works_like_the_braina"
#       "http://${APP_URL}/api/summary?url=https://www.ted.com/talks/isaac_mizrahi_on_fashion_and_creativity"
#       "http://${APP_URL}/api/summary?url=https://www.ted.com/talks/robert_full_the_secrets_of_nature_s_grossest_creatures_channeled_into_robots"
#       "http://${APP_URL}/api/summary?url=https%3A%2F%2Fwww.ted.com%2Ftalks%2Fdon_norman_on_design_and_emotion" )



# for url in "${urls[@]}"
# do
#     response=$(curl -s "$url")
#     echo $response
#     if [[ $(echo $response | jq -e '.summary') && $(echo $response | jq -e '.thumbnail') && $(echo $response | jq -e '.title') && $(echo $response | jq -e '.url') ]]; then
#       echo "Test passed: All expected fields are present in the response for $url"
#     else
#       echo "Test failed: Not all expected fields are present in the response for $url"
#       TEST_STATUS=1
#   fi
# done
