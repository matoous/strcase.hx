(require (prefix-in helix.static. "helix/static.scm"))
(require "helix/misc.scm")
(require "strcase.hx/cogs/strcase-core.scm")

(provide strcase-snake
         strcase-kebab
         strcase-camel
         strcase-pascal
         strcase-screaming-snake
         strcase-title
         strcase-cycle)

(define *strcase-cycle-index* 0)

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
;; Cycle the current selection through snake_case, camelCase, PascalCase, kebab-case, SCREAMING_SNAKE_CASE, and Title Case.
(define (strcase-cycle)
  (define cycle-cases
    (list (list "snake_case" strcase-snake)
          (list "camelCase" strcase-camel)
          (list "PascalCase" strcase-pascal)
          (list "kebab-case" strcase-kebab)
          (list "SCREAMING_SNAKE_CASE" strcase-screaming-snake)
          (list "Title Case" strcase-title)))
  (let* ([case (list-ref cycle-cases *strcase-cycle-index*)]
         [label (list-ref case 0)]
         [command (list-ref case 1)])
    (set! *strcase-cycle-index* (modulo (+ *strcase-cycle-index* 1)
                                        (length cycle-cases)))
    (command)))
