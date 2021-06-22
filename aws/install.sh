#!/usr/bin/env bash

set -ex

if test "$(uname)" = "Darwin"
  then
  exit 0
fi

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
ls -al ./aws/install
./aws/install
rm -r ./aws
rm awscliv2.zip
