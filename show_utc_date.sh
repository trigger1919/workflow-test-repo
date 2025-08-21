#!/bin/bash

# Test workflow
# Display current date and time in UTC format
# Usage: ./show_utc_date.sh [format]
# Environment variable: UTC_DATE_FORMAT

# Function to show usage
show_usage() {
    echo "Usage: $0 [format]"
    echo ""
    echo "Parameters:"
    echo "  format    Date format string (optional)"
    echo ""
    echo "Environment Variables:"
    echo "  UTC_DATE_FORMAT    Default format to use if no parameter provided"
    echo ""
    echo "Examples:"
    echo "  $0                           # Use default or env var format"
    echo "  $0 '%Y-%m-%d %H:%M:%S'       # Custom format"
    echo "  $0 iso                       # Predefined ISO 8601 format"
    echo "  $0 rfc                       # Predefined RFC 3339 format"
    echo "  $0 readable                  # Predefined readable format"
    echo ""
    echo "Predefined formats:"
    echo "  iso       -> %Y-%m-%dT%H:%M:%SZ"
    echo "  rfc       -> %Y-%m-%d %H:%M:%S UTC"
    echo "  readable  -> %A, %B %d, %Y at %H:%M:%S UTC"
    echo "  default   -> %a %b %d %H:%M:%S UTC %Y"
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_usage
    exit 0
fi

# Determine the format to use
format=""

# First priority: command line argument
if [ $# -gt 0 ]; then
    format="$1"
# Second priority: environment variable
elif [ -n "$UTC_DATE_FORMAT" ]; then
    format="$UTC_DATE_FORMAT"
# Default: standard format
else
    format="default"
fi

# Handle predefined format shortcuts
case "$format" in
    "iso")
        format_string="%Y-%m-%dT%H:%M:%SZ"
        ;;
    "rfc")
        format_string="%Y-%m-%d %H:%M:%S UTC"
        ;;
    "readable")
        format_string="%A, %B %d, %Y at %H:%M:%S UTC"
        ;;
    "default")
        format_string="%a %b %d %H:%M:%S UTC %Y"
        ;;
    *)
        # Use the format as-is (custom format string)
        format_string="$format"
        ;;
esac

# Display the formatted date
echo "UTC Date (format: $format):"
date -u +"$format_string"
