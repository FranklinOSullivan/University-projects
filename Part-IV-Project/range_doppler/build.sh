#!/bin/bash

# Check if SWI argument is provided
if [ -z "$1" ]; then
    echo "No argument provided. Building Sequential."
    ARG="MODE=0"
elif [ "${1^^}" == "SWI" ]; then
    echo "SWI argument provided: $1"
    ARG="MODE=2"
elif [ "${1^^}" == "NDR" ]; then
    echo "NDR argument provided: $1"
    ARG="MODE=1"
else
    echo "Invalid argument provided"
    exit 1
fi

# Compiles Host
~/intelFPGA/18.1/embedded/embedded_command_shell.sh << EOF
make clean
make VERBOSE=1 $ARG
EOF

echo "Completed Host Compilation"
