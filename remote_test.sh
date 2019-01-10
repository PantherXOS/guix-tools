#!/usr/bin/env bash


TARGET_PATH="/root/tmp/guix-tools"

ssh root@127.0.0.1 -p 2222 "rm -rf $TARGET_PATH;
                            mkdir -p $TARGET_PATH"

rsync -av -e "ssh -p 2222" --exclude ".git" --exclude "cmake-build-debug" --exclude ".idea" "." "root@127.0.0.1:$TARGET_PATH"

CMD='export GUILE_LOAD_PATH=$GUILE_LOAD_PATH:.'
CMD="$CMD;
     cd $TARGET_PATH;
     guix build --file=test.scm;
#      guix package --install-from-file=test.scm;
#     mkdir -p  build;
#     cd build;
#     cmake ..;
#     make;
#     echo '-----------------------------------------------------';
#     ./src/guix-tools package -j;
     "

ssh root@127.0.0.1 -p 2222 $CMD