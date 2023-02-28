#!/usr/bin/env bash

if ! command -v helm &> /dev/null
then
    echo "Helm cli could not be found. Please install it to deploy wordpress"
    exit
fi