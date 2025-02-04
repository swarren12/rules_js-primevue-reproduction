<!--
  ~~ README.md - Hello, curious person ^_^
  -->

# Vue x PrimeVue x Bazel x `rules_js` reproduction

This repository demonstrates some strange behaviour when using Vue and PrimeVue with Bazel and `rules_js`.

## Steps to reproduce

Ensure that the `pnpm-lock.yaml` is up-to-date:

```shell
$ ./bazelisk-linux-amd64 run -- @pnpm//:pnpm --dir $PWD install --lockfile-only
```

Run the application in developer mode:

```shell
$ ./bazelisk-linux-amd64 run //example:example/dev-mode
```

Open the page:

```shell
$ firefox http://localhost:5173/
```

If everything has worked (or, more specifically, _not worked_) then the "Hello World" button on the page will be unstyled.
It _should_ be an emerald button, but for some reason it isn't.

To confirm the expected layout, kill the `:dev-mode` process and instead run:

```shell
$ cd example
example $ npm install
example $ npx vite dev
```

and re-open the page.

The page should now display correctly, with an emerald button.
