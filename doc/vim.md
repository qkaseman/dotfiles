# Vim

Vim tips and tricks.

## Buffer editing/formatting

You can pipe the full buffer through an external program to format it. One of
the primary times I use this is with minified JSON files and using `jq` to
pretty format it.

```
:%! jq .  -- apply `jq` to the current buffer, equivalent to `> cat <file> | jq . <file>` but won't save for you
|||  `- `jq .` command to run
||`- execute
|`- whole vim buffer
`- vim command character
```
