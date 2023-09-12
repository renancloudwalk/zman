#!/bin/bash

wasm-pack build --target=no-modules || exit 1

if [ ! -f "pkg/manifest.json" ]; then
    cp manifest_v2.json pkg/manifest.json
fi


if [ ! -f "pkg/run_wasm.js" ]; then
  printf "
  const runtime = chrome.runtime || browser.runtime;

  async function run() {
    await wasm_bindgen(runtime.getURL('zman_bg.wasm'));
  }

  run();
  " >> pkg/run_wasm.js
fi
