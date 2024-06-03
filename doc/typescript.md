# TypeScript

> Most of this should apply for JavaScript as well if you're insane enough to
> prefer it.

## `main` guard

As TypeScript, like Python, will execute like a script when you `import` it,
there can be unintended side-effects by importing. `main` guards exist to help
prevent this happening accidentially but still enabling it to happen
intentionally if you want to.

```typescript
/**
 * Execute main script code to do ${THING}.
 *
 * @param argv - command-line argument vector
 */
function main(argv: ReadonlyArray<string>): void {
  /* Your code here. */
}

/*
 * Run the `main` method if this is the main module.
 */
if (require.main === module) {
  main(process.argv);
}
```

## Exposing "private" functions for testing

Proper unit testing can be difficult if you also want to limit the public API
you're exporting. Consider

```typescript
/* Filename: foobar.ts */

type ArgObj = {
  a: string,
  b: string,
  c: number,
};

function baz(args: ArgObj) {
  /* ... */
};

export const foo = (b: string) => (baz({a: 'default', b, c: 0}));
export const bar = (a: string) => (baz({a, b: 'other-default', c: 10}));
```

You could test everything through `foo` and `bar`, which is perfectly valid, but
they may not cover every case you want `baz` to support. In that
case, how do you test it?

### 1. Export it

You could just export it and access it in your tests. This adds it to your
public API in a way you may not want and allows developers to call
`baz` directly. This is by far the simplest option, but also the
most consequential as it could limit changes you can make to
`baz` in the future.

### 2. Export a testing-only object

The first alternative is to export a testing-only object:

```typescript
export __FOR_TESTING_ONLY__ = { baz };
```

This allows you to access it in your tests but also adds it to the visible
public API of the module.

### Modules

A third option is to take advantage of modules within a package, allowing you to
expose the private function within the module but still obscure it from users.
Technically they could still access the function (there's no real way I'm aware
of to prevent that), but it does make it harder as it isn't part of the public
API.

To accomplish this you move from a structure like:

```
- __tests__/
  - foobar.test.ts
- foobar.ts
```

to one like:

```
- foobar/
  - __tests__/
    - index.test.ts
    - baz.test.ts
  - index.ts          # import and use baz, exports foo & bar functions
  - baz.ts            # baz function and relevant helpers all exported
                      # for testing within `foobar` module
```

### Summary

Making the function available for unit testing has the universal downside of it
becomes accessible to someone who is really trying: in option 1 they could
simply `import { baz } from 'foobar'`; option 2, `import { __FOR_TESTING_ONLY__
} from 'foobar'`; option 3, `import { baz } from 'foobar/baz'`.

I find the third option, modules, to be the nicest and most "private" way to
export the function for testing. Anything the module has as a public API should
be exported by `index.ts`, allowing you to freely organize, reorganize, and
change intra-module code.

If people access the internals of a module, they're bypassing the API contract
and are at danger of being unexpectedly broken by changes that *aren't* breaking
API changes.

##
