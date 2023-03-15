#!/bin/bash
set -xeu

echo "----==== Building mitmproxy ====----"

cd mitmproxy
python3 -m venv venv
venv/bin/pip install -e ".[dev]"
echo "Activating venv"
source venv/bin/activate
mitmdump --version
cd ..


echo "----==== Building mitmproxy_rs ====----"

cd mitmproxy_rs/ffi
maturin develop
cd ../..

echo "----==== Finished ====----"
