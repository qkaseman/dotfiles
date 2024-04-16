# CSS

CSS is weird and here is where quirks I don't want to forget go.

## CSS Variables are fully resolved when encountered.

> [JSFiddle](https://jsfiddle.net/km43hopw/) for an example, code for it is
> also below.

CSS variables are useful, but they lose all of their references when they are
encountered. If you have two variables in `:root` with `baz` is a pointer to
`foo` and change `foo`'s meaning outside of `:root`, `baz` won't get updated.

```html
<div class=''>
  <div class='class-foo'>
    This is red.
  </div>

  <div class='class-bar'>
    This is green.
  </div>

  <div class='class-baz'>
    This is red too.
  </div>
</div>
<div class='theme-purple-foo'>
  <div class='class-foo'>
    This was red but now purple.
  </div>

  <div class='class-bar'>
    This is green.
  </div>

  <div class='class-baz'>
    This was red but still red?
  </div>
</div>
```

```css
:root {
  --foo: red;
  --bar: green;
  --baz: var(--foo);
}

.class-foo {
  color: var(--foo);
}

.class-bar {
  color: var(--bar);
}

.class-baz {
  color: var(--baz);
}

.theme-purple-foo {
  --foo: purple;
}
```

## Analysis of CSS files

> Note: These commands are for the macOS `sed`, though they should be portable
> to GNU.

These are some scripts to make analysis of CSS files a bit faster.

Before getting into the scripts, let's cover a few caveats:

1. These aren't intended to be exhaustive and almost assuredly miss things. They
   exist to give a rough idea of declarations, counts, etc...
1. These scripts consider `!important` as part of the value, so `0` and `0
   !important` are not the same declaration.
1. These scripts *will* miss any declarations that don't end in `;`. Properly
   formatting your CSS files is easier than a more complicated parser.

macOS loves to be weird and its `re_format` doesn't support extended literals,
so you can't use ` \t` for matching spaces and tabs, it would literally match
those three characters. This is doubly confusing as `-E` in `man sed` saying it
supports the "extended (modern) regex" but literal sequences like \s and \t are
"enhanced" regex syntax which can be added on to both the base and "extended"
regex syntax. Because confusion.

`[[:blank:]]` uses character classes and does the same just a little weirder.
You can see all of the classes with `man ctype` and specifically `blank` with
`man isblank`.

### Count the unique style declarations:

```bash
> cat ${ALL_CSS_FILES_HERE} |
    sed -E '
      s/^[[:blank:]]*//; # Regex substitution to strip leading spaces/tabs.
      s/\s*$//;          # Regex substitution to strip trailing whitespace.
      /^(@|\*)/d;        # Regex match lines starting with `@` or `*` and delete them, some comments and at-directives end in `;`.
      /;$/!d;            # Regex match lines ending with `;` and delete non-matching ones.' |
    sort |
    uniq > unique-style-declarations.txt
```

In one line:

```bash
> cat ${ALL_CSS_FILES_HERE} | sed -E 's/^[[:blank:]]*//;s/\s*$//;/^(@|\*)/d;/;$/!d;' | sort | uniq > unique-style-declarations.txt
```

> You can change `uniq` to `uniq -c | sort -nr` to get counts for how many times
> each unique style declaration appears.

### Get the unique style properties defined:

```bash
> cat ${ALL_CSS_FILES_HERE} |
    sed -E '
      s/^[[:blank:]]*//; # Regex substitution to strip leading spaces/tabs.
      s/\s*$//;          # Regex substitution to strip trailing whitespace.
      /^(@|\*)/d;        # Regex match lines starting with `@` or `*` and delete them, some comments and at-directives end in `;`.
      /;$/!d;            # Regex match lines ending with `;` and delete non-matching ones.
      s/:.*//;           # Regex substitution to strip value declarations.' |
    sort |
    uniq > unique-prop-names.txt
```

In one line:

```bash
> cat ${ALL_CSS_FILES_HERE} | sed -E 's/^[[:blank:]]*//;s/\s*$//;/^(@|\*)/d;/;$/!d;s/:.*//' | sort | uniq > unique-prop-names.txt
```

> Again, you can change `uniq` to `uniq -c | sort -nr` to get counts.

### Get all unique values for each style property

> Note: This command assumes you've used the command above that generates
> `unique-style-declarations.txt` first.
>
> This command is also a bit complicated, but I do my best to explain it below.

```bash
> sed '
    $!N;                    # For all but the last line, add the line to the pattern buffer.
    /^\(.*:\)\(.*\)\n\1/!P; # Put the declaration into the first match group, the value into the second, and see if the next line
                            # starts with the same declaration. If not, print the line (`!P`).
    s//\n\1\2 |/;           # Regex substitution using the most recently used regex (`s//`) and replace it with a newline, the
                            # first match group, the second match group, and a ` |`.
    D;                      # Delete everything to the first newline in the pattern buffer. This is why the regex substitution
                            # includes a leading `\n`, this will strip it out while keeping the rest of the pattern in place.
  ' unique-style-declarations.txt > unique-vals-per-prop.txt
```

In one line:

```bash
> sed '$!N;/^\(.*:\)\(.*\)\n\1/!P;s//\n\1\2 |/;D' unique-style-declarations.txt > unique-vals-per-prop.txt
```
