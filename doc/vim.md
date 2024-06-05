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

## Tree-sitter

> [Tree-sitter](https://tree-sitter.github.io/tree-sitter/)
> [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

## Get the LSP syntax kind for highlighting

> `kind` is used instead of `type` with syntax identifiers as the tree
> may store or identify `type` as well.

You can use the `:Inspect` command to do this. For example, `:Inspect` on
`syntax` in the heading above gives:

```
Treesitter
  - @markup.heading.2.markdown markdown
  - @spell.markdown links to @spell markdown
```

As far as I know, the top-level syntax kind gets applied but the others can
briefly show up in flashes while things are initially loading.
