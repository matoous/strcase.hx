(require (prefix-in helix.static. "helix/static.scm"))
(require "helix/misc.scm")
(require "strcase.hx/cogs/strcase-core.scm")

(provide strcase-snake
         strcase-kebab
         strcase-camel
         strcase-pascal
         strcase-screaming-snake
         strcase-title
         strcase-smart-case-upper
         strcase-smart-case-lower
         strcase-smart-case-dictionary
         strcase-set-smart-case-dictionary!
         strcase-extend-smart-case-dictionary!)

(define (selection-text)
  (helix.static.current-highlighted-text!))

(define (replace-selection-with-transform transform label)
  (let* ([before (selection-text)]
         [after (transform before)])
    (if (equal? before "")
        (set-warning! "strcase.hx: select text to convert")
        (begin
          (helix.static.replace-selection-with after)
          (set-status! (string-append "strcase.hx: " label))))))

;;@doc
;; Convert the current selection to snake_case.
(define (strcase-snake)
  (replace-selection-with-transform strcase->snake "snake_case"))

;;@doc
;; Convert the current selection to kebab-case.
(define (strcase-kebab)
  (replace-selection-with-transform strcase->kebab "kebab-case"))

;;@doc
;; Convert the current selection to camelCase.
(define (strcase-camel)
  (replace-selection-with-transform strcase->camel "camelCase"))

;;@doc
;; Convert the current selection to PascalCase.
(define (strcase-pascal)
  (replace-selection-with-transform strcase->pascal "PascalCase"))

;;@doc
;; Convert the current selection to SCREAMING_SNAKE_CASE.
(define (strcase-screaming-snake)
  (replace-selection-with-transform strcase->screaming-snake "SCREAMING_SNAKE_CASE"))

;;@doc
;; Convert the current selection to Title Case.
(define (strcase-title)
  (replace-selection-with-transform strcase->title "Title Case"))

;;@doc
;; Convert the current selection to Go-style exported smart case.
(define (strcase-smart-case-upper)
  (replace-selection-with-transform strcase->smart-case-upper "SmartCase"))

;;@doc
;; Convert the current selection to Go-style unexported smart case.
(define (strcase-smart-case-lower)
  (replace-selection-with-transform strcase->smart-case-lower "smartCase"))
