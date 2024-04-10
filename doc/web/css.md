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
