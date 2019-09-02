#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo "Usage: $0 <toolchain> (e.g. x86_64-apple-darwin)"
    exit
fi

for test_name in \
    'basic' 'exact-match' 'module-substring' \
    'search-short-types' 'substring'
do
    echo "Checking '$test_name'..."
    build/$1/stage1/bin/rustdoc \
        -o src/test/rustdoc-js/$test_name \
        src/test/rustdoc-js/$test_name.rs
    node src/tools/rustdoc-js/tester.js src/test/rustdoc-js $test_name
    rm -rf src/test/rustdoc-js/$test_name
done
