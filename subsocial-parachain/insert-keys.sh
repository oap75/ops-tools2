#!/bin/bash
docker exec -it subsocial-collator bash -c "curl http://localhost:8833 -H \"Content-Type:application/json;charset=utf-8\" -d \"@/data/aura.json\""

echo "Aura key added to the parachain collator"

