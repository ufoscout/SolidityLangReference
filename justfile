# export RUST_BACKTRACE := "full"
# WASM_DIR := env("WASM_DIR", "./target/wasm32-unknown-unknown/release")

# Lists all the available commands
default:
  @just --list

build args="": install
  forge build {{args}}

build_with_sizes: install
  @just build --sizes

test:
  forge test -vvv

install:
  forge soldeer install
  
fmt args="":
  forge fmt {{args}}

fmt_check:
  just fmt "--check"

clean:
  rm -rf dependencies
  forge clean
