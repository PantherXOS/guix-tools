#!/usr/bin/env bash


TARGET_PATH="/root/tmp/pjson"

ssh root@127.0.0.1 -p 2222 "rm -rf $TARGET_PATH;
                            mkdir -p $TARGET_PATH"

rsync -av -e "ssh -p 2222" scripts/* "root@127.0.0.1:$TARGET_PATH"

CMD='export GUILE_LOAD_PATH=$GUILE_LOAD_PATH:.'
CMD="$CMD;
     cd $TARGET_PATH;
     echo '-----------------------------------------------------';
     guile --no-auto-compile -s test.scm"
ssh root@127.0.0.1 -p 2222 $CMD