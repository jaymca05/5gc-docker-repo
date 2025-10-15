#!/bin/sh
export LD_LIBRARY_PATH=/open5gs/lib/x86_64-linux-gnu:${LD_LIBRARY_PATH}
exec /open5gs/open5gs-nrfd -c /open5gs/config.yaml

