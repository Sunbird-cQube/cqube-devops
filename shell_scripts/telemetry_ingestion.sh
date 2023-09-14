#!/bin/bash

sudo docker exec -i spec_app sh << 'EOF'
apk add curl
curl --location 'http://spec_app:3001/event' --header 'Content-Type:application/json' --data '{"program":"telemetry","input":{"type":"object","properties":{"date":{"type":"string","shouldNotNull":false},"timestamp":{"type":"number","shouldNotNull":false},"userId":{"type":"string","shouldNotNull":false},"pageName":{"type":"string","shouldNotNull":false},"pageEvent":{"type":"string","shouldNotNull":false},"pageEventName":{"type":"string","shouldNotNull":false},"deviceType":{"type":"string","shouldNotNull":false},"userLocation":{"type":"string","shouldNotNull":false},"browserType":{"type":"string","shouldNotNull":false},"timeSpent":{"type":"number","shouldNotNull":false},"timeIn":{"type":"number","shouldNotNull":false},"timeOut":{"type":"number","shouldNotNull":false}},"required":["date","timestamp","userId","pageName","pageEvent","pageEventName","deviceType","userLocation","browserType","timeSpent","timeIn","timeOut"]}}'
EOF
