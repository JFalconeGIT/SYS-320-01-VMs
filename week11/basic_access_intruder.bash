#!/bin/bash

# Access the web page 20 times in a row

for i in {1..20}
do

  echo "Request $i:"
  curl http://10.0.17.6
done
