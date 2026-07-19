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
         strcase-smart-case-upper
         strcase-smart-case-lower)
```

Requiring the plugin installs the default global keybindings for normal and select mode:

```text
`s  snake_case
`k  kebab-case
`c  camelCase
`p  PascalCase
`S  SCREAMING_SNAKE_CASE
`t  Title Case
`g  smartCase with Go initialisms
`G  SmartCase with Go initialisms
`u  UPPERCASE
`l  lowercase
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
:strcase-smart-case-upper
:strcase-smart-case-lower
```

The smart-case commands use Go-style common initialisms:

```text
http_test -> HTTPTest
test_http -> testHTTP
```

Extend or override the dictionary from `~/.config/helix/helix.scm` after requiring
the plugin:

```scheme
(strcase-extend-smart-case-dictionary!
  (list "Haxe" "Http"))
```

Replace the full dictionary with:

```scheme
(strcase-set-smart-case-dictionary!
  (list "Api"))
```

Examples:

```text
hello world -> hello_world
hello_world -> helloWorld
HTTP response_code -> http_response_code
```
