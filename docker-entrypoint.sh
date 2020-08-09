#!/usr/bin/env bash

# exit on error
set -e

_term() {
  echo "`date +%F\ %T` ########################################################### Caught SIGTERM signal, stopping!"

  exit 0
}

#trap _term SIGTERM


####################################################################### WAIT ###########################################
# wait forever - have signal handler do the exit
tail -f /dev/null & wait

echo "`date +%F\ %T` docker-entrypoint.sh exiting!"
exit 0
