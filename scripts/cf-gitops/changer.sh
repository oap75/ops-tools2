#!/bin/bash

# receive filename as parameter
filename=$1

change_record_ip () {
  record="${1:-sub.id}"

  url=https://api.cloudflare.com/client/v4/zones/$cf_zone/dns_records?type=A&name=$record&content=$current_ip&proxied=true&page=1&per_page=100&order=type&direction=desc&match=all
 
  record_id="$(echo $(curl -X GET "$url"  -H "X-Auth-Email:$cf_mail"  -H "Authorization:Bearer $cf_token"  -H "Content-Type:application/json" |  jq . | jq -c '.result[]' | jq -r .id) 2>/dev/null)"
  status=$?

  if [ $status -eq 0 ]; then

    echo [INFO] - Changing $record IP from $current_ip to $new_ip

    curl -X PUT "https://api.cloudflare.com/client/v4/zones/$cf_zone/dns_records/$record_id"  -H "X-Auth-Email:$cf_mail"  -H "Authorization:Bearer $cf_token"  -H "Content-Type:application/json" --data '{"type":"A","name":"$record","content":"$new_ip","ttl":3600,"priority":10,"proxied":true}'
    
  else
    echo [ERROR] - Could not change $record IP from $current_ip to $new_ip
    
  fi
}

while read in; do
    change_record_ip $in
done < $filename

# Exit the script
exit 0
