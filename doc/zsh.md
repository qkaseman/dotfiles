# ZSH

Document for "fun" (i.e. useful) `zsh` tricks.

## Previous command expansion

`zsh` has a built-in way to expand the arguments from the previous command into your current line.

```bash
> ls /path/to/dir
> cd !!*<TAB>
> cd /path/to/dir
```

* `!!<TAB>` -- entire previous line, including command name
* `!!*<TAB>` -- all argument in previous line
* `!!X<TAB>` -- get `X` positional argument of the previous line
* `!!$<TAB>` -- get last argument of the previous line
* `!!X*<TAB>` -- skip `X` arguments of the previous line and expand the rest

## `pwd` path replacement

`zsh` has a built-in option to swap parts of the current working directory path. `cd <arg1> <arg2>` will swap `arg1` and `arg2` in `pwd`.

```bash
> pwd
~/code/dev/proj1/packages/package/
> cd dev clean
> pwd
~/code/clean/proj1/packages/package/
```

## `zmv`: easy file renaming

`zmv` is an easy way to change file names with globbing and replacement. For example, if you want to change the extension of all `.txt` files to `.html`, you can do `zmv '(*).txt' '$1.html'`. I believe the `$1` (and likely any other `$X` variables correspond to the glob match as defined by the `()`.

```bash
> ls
file1.txt file2.txt
> zmv '(*).txt' '$1.html'
> ls
file1.html file2.html
```

## `vared`: easy environment editing

`vared` is a built in way to edit the current shell environment.

## Suffix aliases

`zsh` provides a way to create "suffix aliases" where the last part of a command indicates the alias to expand at the **start** of the command. A suffix alias is indicated by `-s` in the definition.

```
> alias -s ts=vim
> file.ts # suffix alias `ts` gets triggered and this becomes `vim file.ts`
```
