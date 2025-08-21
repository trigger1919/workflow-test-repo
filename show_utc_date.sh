#!/bin/bash

# Display current date and time in UTC format
echo "Current UTC date and time:"
date -u

# Alternative formats you might find useful:
echo ""
echo "ISO 8601 format:"
date -u +"%Y-%m-%dT%H:%M:%SZ"

echo ""
echo "RFC 3339 format:"
date -u +"%Y-%m-%d %H:%M:%S UTC"

echo ""
echo "Custom readable format:"
date -u +"%A, %B %d, %Y at %H:%M:%S UTC"
