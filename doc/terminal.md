# Terminal

General terminal commands.

## Job control

* `CTRL-z` -- suspend current terminal foreground job
* `bg` -- send CONT signal to most recent terminal job, usually resuming it in the background
* `fg` -- resume the most recent terminal job
* `jobs` -- list terminal processes
* `fg %X` -- foreground terminal job `X` where `X` is the job number from `jobs`
* `bg %X` -- resume background job `X` where `X` is the job number from `jobs`

## `pacman` command line install wrapper

Install [pacaptr](https://github.com/rami3l/pacaptr) which is a Rust-based
wrapper around a bunch of package managers that allows using the `pacman`-style
syntax.
