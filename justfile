python := `which python`

default:
  @just --list --unsorted

build: (build-side "left") (build-side "right")

build-side side:
  west build \
     -s zmk/app \
     -d zmk/app/build/{{ side }} \
     -b nice_nano_v2 \
     -- -DZMK_CONFIG={{justfile_directory()}}/config -DSHIELD=chocofi_{{ side }} \
        -DPYTHON_PREFER_EXECUTABLE={{ python }}
