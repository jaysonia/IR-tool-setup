#!/bin/bash

EXPECTED_VALUE=262144
CURRENT_VALUE=$(cat /proc/sys/vm/max_map_count)

# --- Start of Conditional Check ---
if [ "$CURRENT_VALUE" -eq "$EXPECTED_VALUE" ]; then
    echo "✅ SUCCESS: vm.max_map_count is set to the expected value: $EXPECTED_VALUE"
    exit 0
else
    echo "❌ WARNING: vm.max_map_count is currently $CURRENT_VALUE."
    echo "Updating value to ${EXPECTED_VALUE}"
    sudo sysctl -w vm.max_map_count=$EXPECTED_VALUE 
    exit 0
fi