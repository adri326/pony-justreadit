# pony-justreadit

A pony library that just reads files.

## What it does

- reads files
- prints out an error if it can't
- calls a function on success

## What it doesn't

- any default behavior (create an empty file, etc.)
- wildcards
- advanced things
- anything fancy

## How to...

### Install it

Add it using [corral](https://github.com/ponylang/corral):

```sh
corral add github.com/adri326/pony-justreadit.git
```

Alternatively, you can just clone this repository and add `./pony-justreadit` (or whichever folder you put it in) to `ponyc`'s `--path` argument.

### Use it

Once you have installed it, you can include it in your code:

```pony
use "justreadit"

actor Main
  let env: Env
  new create(env': Env) =>
    env = env'
    JustRead("file.txt", env, this~print_reverse())

  fun print_reverse(str: String) =>
    env.out.print(str.reverse())
```

`JustRead` will call whichever function you give it as third argument with the read string. You may give it a lambda too.

### Remove it

Remove it from corral's dependencies:

```sh
corral remove github.com/adri326/pony-justreadit.git
```

Remove any `use "justreadit"` in your code and replace the ugly `JustRead`s with your preffered method of loading files.

### Contribute

Post issues and pull request to [this repository](https://github.com/adri326/pony-justreadit/)!
