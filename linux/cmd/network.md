ip addr show | grep inet | awk '{ print $2; }' | sed 's/\/.*$//'


