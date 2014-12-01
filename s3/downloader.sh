#!/bin/bash
set -e

S3_FILE=https://s3-eu-west-1.amazonaws.com/BUCKET/runner.sh

RUNNER=$(curl -s $S3_FILE)
. /dev/stdin <<< "$RUNNER"

$COMMAND $*
