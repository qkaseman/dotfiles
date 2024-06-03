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

```bash
> alias -s ts=vim
> file.ts # suffix alias `ts` gets triggered and this becomes `vim file.ts`
```

## Scripting

### Safer Scripts with `set -euxo pipefail`

> More detailed explanation: https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

Adding `set -euxo pipefail` to the top of shell scripts is useful for catching
errors:

- `-e`: any non-zero exit status causes an immediate script failure
- `-u`: unset variables are errors too, if you want a default use
  `${VAR:-$DEFAULT}`
- `-x`: print commands before executing them
- `-o pipefail`: exit status of a pipeline of commands becomes the right-most
  non-zero exit status even if the final part of the pipeline exited with `0`

### Terniary in shell scripts

```bash
[ ${TEST_EXPR} ] && ${TRUE_EXPR} || ${FALSE_EXPR}
```

You can create terniary expressions in shell scripting using a test expression
and then `&&`/`||` chaining. I often use this when checking for a file or
directory, particularly when a simple command or creation is the next step.

There are two important facts to be aware of doing this:

1. `[ ${TEST_EXPR} ]` will be `0` if `${TEST_EXPR}` evaluates to`true` and `1`
   if it evaluates to `false`. This is the opposite of most programming
   languages where `0` is `false` and any non-`0` is `true`.
1. You *must* do `&& ${TRUE_EXPR} || ${FALSE_EXPR}`. Doing it reverse will
   execute `${TRUE_EXPR}` if `${FALSE_EXPR}` executes successfully (non-`0` exit
   code), which is *not* what you want.

#### Terniary with `set -e`

If you have `-e` set, you need to ensure the overall terniary expression has a
`0` exit code, otherwise the script will fail. This is relevant when you don't
actually have a `false` condition you want to execute which would allow the
`${TEST_EXPR}`'s `false` exit code of `1` to be the terniary exit code. You can
fix this by adding `|| true`:

```bash
[ -f ${ZSH_LOCAL_HOME}/zshrc ] && . ${ZSH_LOCAL_HOME}/zshrc || true
```
