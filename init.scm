(require (prefix-in strcase. "strcase.hx/cogs/strcase-hx.scm"))
(require (only-in "helix/keymaps.scm" keymap))

(provide
  strcase-snake
  strcase-kebab
  strcase-camel
  strcase-pascal
  strcase-screaming-snake
  strcase-title
  strcase-cycle
  strcase-install-keybindings)

(define (strcase-install-keybindings)
  (keymap (global)
          (normal ("`" (s ":strcase-snake")
                       (k ":strcase-kebab")
                       (c ":strcase-camel")
                       (p ":strcase-pascal")
                       (S ":strcase-screaming-snake")
                       (t ":strcase-title")
                       (u "switch_to_uppercase")
                       (l "switch_to_lowercase")
                       ("`" ":strcase-cycle")))
          (select ("`" (s ":strcase-snake")
                       (k ":strcase-kebab")
                       (c ":strcase-camel")
                       (p ":strcase-pascal")
                       (S ":strcase-screaming-snake")
                       (t ":strcase-title")
                       (u "switch_to_uppercase")
                       (l "switch_to_lowercase")
                       ("`" ":strcase-cycle")))))

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
;; Cycle the current selection through the available string cases.
(define (strcase-cycle)
  (strcase.strcase-cycle))

(strcase-install-keybindings)
