#!/bin/bash

# List all the IPs in the given network prefix
# /24

# Usage: bash IPList.bash 10.0.17
[ $# -ne 1 ] && echo "Usage: $0 <Prefix>" && exit

# Prefix is the first input taken
prefix=$1

# Verify input length
if [ ${#prefix} -lt 5 ]; then
printf "Prefix length is too short\nPrefix example: 10.0.17\n"
exit 1
fi

echo "Scanning $prefix.0/24 for active hosts..."

for i in {1..254}
do
  ip="$prefix.$i"
  # -c 1 = send 1 packet, -W 1 = wait 1 second max
  if ping -c 1 -W 1 $ip &> /dev/null; then
      echo "$ip is active"
  fi
done
