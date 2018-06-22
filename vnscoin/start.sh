#!/bin/bash
if [ "$#" -ne 1 ]; then
  echo "Please provide your vnsbase"
  exit 0
fi

gvns --fast --cache=1024 --maxpeers 10000 --mine --vnsbase $1
