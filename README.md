<div align="center">

# strcase.hx

</div>

A [Helix](https://github.com/helix-editor/helix) plugin for converting string cases.

## Install

Install:

```sh
forge pkg install --git https://github.com/matoous/strcase.hx
```

Then expose the commands from `~/.config/helix/helix.scm`:

```scheme
(require "strcase.hx")

(provide strcase-snake
         strcase-kebab
         strcase-camel
         strcase-pascal
         strcase-screaming-snake
         strcase-title
         strcase-cycle)
```

Requiring the plugin installs the default global keybindings for normal and select mode:

```text
`s  snake_case
`k  kebab-case
`c  camelCase
`p  PascalCase
`S  SCREAMING_SNAKE_CASE
`t  Title Case
`u  UPPERCASE
`l  lowercase
``  cycle cases
```

## Usage

Select text and run:

```text
:strcase-snake
:strcase-kebab
:strcase-camel
:strcase-pascal
:strcase-screaming-snake
:strcase-title
:strcase-cycle
```

`strcase-cycle` rotates through:

```text
snake_case -> camelCase -> PascalCase -> kebab-case -> SCREAMING_SNAKE_CASE -> Title Case
```

Examples:

```text
hello world -> hello_world
hello_world -> helloWorld
HTTP response_code -> http_response_code
```
