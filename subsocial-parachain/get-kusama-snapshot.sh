#!/bin/bash

set -e

SNAP_DIR="$PWD/kusama-snapshot"

rm -rf $SNAP_DIR && mkdir $SNAP_DIR

wget https://ksm-rocksdb.polkashots.io/snapshot -O kusama.RocksDb.tar.lz4
lz4 -c -d kusama.RocksDb.tar.lz4 | tar -x -C $SNAP_DIR
rm kusama.RocksDb.tar.lz4
