MINIMODEM_BC = build/minimodem/src/minimodem.bc
MINIMODEM_PC_PATH = ../libsndfile/dist/lib/pkgconfig:../fftw3/dist/lib/pkgconfig

all: minimodem
minimodem: dist/minimodem.js


build/libsndfile/configure:
	cd build/libsndfile && ./autogen.sh

build/libsndfile/dist/lib/libsndfile.so: build/libsndfile/configure
	cd build/libsndfile && \
	emconfigure ./configure \
		CFLAGS=-O3 \
		--prefix="$$(pwd)/dist" \
		--disable-external-libs \
		&& \
	emmake make && \
	emmake make install

build/fftw3/dist/lib/lib/libfftw3f.so:
	cd build/fftw3 && \
	emconfigure ./configure \
		CFLAGS=-O3 \
		--prefix="$$(pwd)/dist" \
		--disable-doc \
		--disable-fortran \
		--enable-float \
		&& \
	emmake make && \
	emmake make install

build/minimodem/configure:
	cd build/minimodem && autoreconf -vfi

build/minimodem/minimodem.bc: build/minimodem/configure $(MINIMODEM_SHARED_DEPS)
	cd build/minimodem && \
	EM_PKG_CONFIG_PATH=$(MINIMODEM_PC_PATH) emconfigure ./configure \
			--without-alsa \
			--without-pulseaudio \
			--disable-benchmarks \
			&& \
		emmake make && \
		cp src/minimodem src/minimodem.bc

dist/minimodem.js: $(MINIMODEM_BC)
	mkdir -p dist && \
	emcc $(MINIMODEM_BC) \
		-O2 \
		-s FORCE_FILESYSTEM=1 \
		-s INVOKE_RUN=0  \
		-s EXPORT_ES6=1 \
		-s MODULARIZE=1 \
		-s EXIT_RUNTIME=1 \
		-s 'EXTRA_EXPORTED_RUNTIME_METHODS=["callMain", "FS"]' \
		--post-js build/post.js \
		-o $@