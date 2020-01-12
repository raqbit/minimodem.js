# Minimodem.js

Currently just a build setup for building [MiniModem](https://github.com/kamalmostafa/minimodem/) into a WASM binary using [Emscripten](https://emscripten.org/).

## Building

1. [Download & setup the EMSDK](https://emscripten.org/docs/getting_started/downloads.html).

2. Activate your EMSDK environment: `source $EMSDK/emsdk_env.sh`

3. Download submodules

   ```sh
   git submodule init
   git submodule update --recursive
   ```

4. Build MiniModem and it's dependencies

   ```sh
   make all
   ```

## Todo

- Write a library around plain exec?

## Licenses

Own library code licensed under the MIT license.

**MiniModem** is licensed under the GNU General Public License v3.

Included libraries:

- **libsndfile** - Licensed under the GNU General Public License v2.1.
- **fftw3f** - Licensed under the GNU General Public License v2.
