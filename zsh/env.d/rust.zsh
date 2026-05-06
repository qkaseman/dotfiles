# Rust toolchain paths (rustup/cargo don't respect XDG natively).
export RUSTUP_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/rustup"
export CARGO_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/cargo"
# Prepend: cargo-installed binaries should take precedence over system versions.
path=("${CARGO_HOME}/bin" $path)
