#!/usr/bin/env bash
# Test OptimoCMS MCP server connectivity.
# Usage: OPTIMOCMS_API_KEY=omc_xxx ./scripts/test-connection.sh

set -euo pipefail

ENDPOINT="https://europe-west4-cms-sg.cloudfunctions.net/mcpServer"
API_KEY="${OPTIMOCMS_API_KEY:-}"

if [ -z "$API_KEY" ]; then
  echo "ERROR: OPTIMOCMS_API_KEY environment variable is not set."
  echo "Set it with: export OPTIMOCMS_API_KEY=\"omc_your_key_here\""
  exit 1
fi

echo "Testing OptimoCMS MCP server connection..."
echo "Endpoint: $ENDPOINT"
echo ""

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
  -X POST "$ENDPOINT" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}')

if [ "$HTTP_CODE" -eq 200 ]; then
  echo "SUCCESS: MCP server is reachable and authenticated (HTTP $HTTP_CODE)"
  echo ""
  echo "Fetching available tools..."
  curl -s -X POST "$ENDPOINT" \
    -H "Authorization: Bearer $API_KEY" \
    -H "Content-Type: application/json" \
    -d '{"jsonrpc":"2.0","id":1,"method":"tools/list","params":{}}' \
    | python3 -c "import sys,json; tools=json.load(sys.stdin).get('result',{}).get('tools',[]); [print(f'  - {t[\"name\"]}') for t in tools]" 2>/dev/null \
    || echo "  (install python3 to see tool names)"
elif [ "$HTTP_CODE" -eq 401 ] || [ "$HTTP_CODE" -eq 403 ]; then
  echo "FAILED: Authentication error (HTTP $HTTP_CODE)"
  echo "Check that your API key is valid and starts with omc_"
  exit 1
else
  echo "FAILED: Unexpected response (HTTP $HTTP_CODE)"
  echo "The MCP server may be temporarily unavailable."
  exit 1
fi
