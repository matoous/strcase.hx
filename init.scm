(require (prefix-in strcase. "strcase.hx/cogs/strcase-hx.scm"))
(require (only-in "helix/keymaps.scm" keymap))

(provide
  strcase-snake
  strcase-kebab
  strcase-camel
  strcase-pascal
  strcase-screaming-snake
  strcase-title
  strcase-smart-case-upper
  strcase-smart-case-lower
  strcase-smart-case-dictionary
  strcase-set-smart-case-dictionary!
  strcase-extend-smart-case-dictionary!
  strcase-install-keybindings)

(define (strcase-install-keybindings)
  (keymap (global)
          (normal ("`" (s ":strcase-snake")
                       (k ":strcase-kebab")
                       (c ":strcase-camel")
                       (p ":strcase-pascal")
                       (S ":strcase-screaming-snake")
                       (t ":strcase-title")
                       (g ":strcase-smart-case-lower")
                       (G ":strcase-smart-case-upper")
                       (u "switch_to_uppercase")
                       (l "switch_to_lowercase")))
          (select ("`" (s ":strcase-snake")
                       (k ":strcase-kebab")
                       (c ":strcase-camel")
                       (p ":strcase-pascal")
                       (S ":strcase-screaming-snake")
                       (t ":strcase-title")
                       (g ":strcase-smart-case-lower")
                       (G ":strcase-smart-case-upper")
                       (u "switch_to_uppercase")
                       (l "switch_to_lowercase")))))

;;@doc
;; Convert the current selection to snake_case.
(define (strcase-snake)
  (strcase.strcase-snake))

;;@doc
;; Convert the current selection to kebab-case.
(define (strcase-kebab)
  (strcase.strcase-kebab))

;;@doc
;; Convert the current selection to camelCase.
(define (strcase-camel)
  (strcase.strcase-camel))

;;@doc
;; Convert the current selection to PascalCase.
(define (strcase-pascal)
  (strcase.strcase-pascal))

;;@doc
;; Convert the current selection to SCREAMING_SNAKE_CASE.
(define (strcase-screaming-snake)
  (strcase.strcase-screaming-snake))

;;@doc
;; Convert the current selection to Title Case.
(define (strcase-title)
  (strcase.strcase-title))

;;@doc
;; Convert the current selection to Go-style exported smart case.
(define (strcase-smart-case-upper)
  (strcase.strcase-smart-case-upper))

;;@doc
;; Convert the current selection to Go-style unexported smart case.
(define (strcase-smart-case-lower)
  (strcase.strcase-smart-case-lower))

(define (strcase-smart-case-dictionary)
  (strcase.strcase-smart-case-dictionary))

(define (strcase-set-smart-case-dictionary! dictionary)
  (strcase.strcase-set-smart-case-dictionary! dictionary))

(define (strcase-extend-smart-case-dictionary! dictionary)
  (strcase.strcase-extend-smart-case-dictionary! dictionary))

(strcase-install-keybindings)
