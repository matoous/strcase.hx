(provide strcase->snake
         strcase->kebab
         strcase->camel
         strcase->pascal
         strcase->screaming-snake
         strcase->title
         strcase->smart-case-upper
         strcase->smart-case-lower
         strcase-smart-case-dictionary
         strcase-set-smart-case-dictionary!
         strcase-extend-smart-case-dictionary!)

(define *strcase-default-smart-case-dictionary*
  (list "ACL"
        "API"
        "ASCII"
        "CPU"
        "CSS"
        "DNS"
        "EOF"
        "GUID"
        "HTML"
        "HTTP"
        "HTTPS"
        "ID"
        "IP"
        "JSON"
        "LHS"
        "QPS"
        "RAM"
        "RHS"
        "RPC"
        "SLA"
        "SMTP"
        "SQL"
        "SSH"
        "TCP"
        "TLS"
        "TTL"
        "UDP"
        "UI"
        "UID"
        "UUID"
        "URI"
        "URL"
        "UTF8"
        "VM"
        "XML"
        "XMPP"
        "XSRF"
        "XSS"))

(define *strcase-smart-case-dictionary* *strcase-default-smart-case-dictionary*)

(define (ascii-upper? char)
  (and (char>=? char #\A) (char<=? char #\Z)))

(define (ascii-lower? char)
  (and (char>=? char #\a) (char<=? char #\z)))

(define (ascii-digit? char)
  (and (char>=? char #\0) (char<=? char #\9)))

(define (ascii-alnum? char)
  (or (ascii-upper? char) (ascii-lower? char) (ascii-digit? char)))

(define (word-break-before? previous-char char next-char)
  (and previous-char
       (or (and (ascii-lower? previous-char) (ascii-upper? char))
           (and (ascii-upper? previous-char)
                (ascii-upper? char)
                next-char
                (ascii-lower? next-char))
           (and (not (ascii-digit? previous-char)) (ascii-digit? char))
           (and (ascii-digit? previous-char) (not (ascii-digit? char))))))

(define (push-word word words)
  (if (equal? word "")
      words
      (cons word words)))

(define (scan-words value index current-word scanned-words previous-char)
  (if (>= index (string-length value))
      (reverse (push-word current-word scanned-words))
      (let ([char (string-ref value index)]
            [piece (substring value index (+ index 1))]
            [next-char (if (< (+ index 1) (string-length value))
                           (string-ref value (+ index 1))
                           #false)])
        (if (ascii-alnum? char)
            (let ([break-before? (word-break-before? previous-char char next-char)])
              (scan-words value
                          (+ index 1)
                          (if break-before? piece (string-append current-word piece))
                          (if break-before? (push-word current-word scanned-words) scanned-words)
                          char))
            (scan-words value
                        (+ index 1)
                        ""
                        (push-word current-word scanned-words)
                        #false)))))

(define (strcase-words value)
  (filter (lambda (word) (not (equal? word "")))
          (scan-words value 0 "" '() #false)))

(define (capitalize-word word)
  (if (equal? word "")
      word
      (string-append (string-upcase (substring word 0 1))
                     (string-downcase (substring word 1 (string-length word))))))

(define (remove-dictionary-key key dictionary)
  (filter (lambda (entry) (not (string-ci=? entry key))) dictionary))

(define (prepend-dictionary-entry entry dictionary)
  (cons entry (remove-dictionary-key entry dictionary)))

(define (prepend-dictionary-entries entries dictionary)
  (if (null? entries)
      dictionary
      (prepend-dictionary-entries (cdr entries)
                                  (prepend-dictionary-entry (car entries) dictionary))))

(define (lookup-smart-case-word word dictionary)
  (if (null? dictionary)
      #false
      (let ([entry (car dictionary)])
        (if (string-ci=? entry word)
            entry
            (lookup-smart-case-word word (cdr dictionary))))))

(define (smart-case-word word)
  (let ([dictionary-entry (lookup-smart-case-word word *strcase-smart-case-dictionary*)])
    (if dictionary-entry
        dictionary-entry
        (capitalize-word word))))

(define (strcase-smart-case-dictionary)
  *strcase-smart-case-dictionary*)

(define (strcase-set-smart-case-dictionary! dictionary)
  (set! *strcase-smart-case-dictionary* dictionary))

(define (strcase-extend-smart-case-dictionary! dictionary)
  (set! *strcase-smart-case-dictionary*
        (prepend-dictionary-entries dictionary *strcase-smart-case-dictionary*)))

(define (join-with words separator)
  (if (null? words)
      ""
      (foldl (lambda (word result) (string-append result separator word))
             (car words)
             (cdr words))))

(define (strcase->snake value)
  (join-with (map string-downcase (strcase-words value)) "_"))

(define (strcase->kebab value)
  (join-with (map string-downcase (strcase-words value)) "-"))

(define (strcase->pascal value)
  (apply string-append (map capitalize-word (strcase-words value))))

(define (strcase->camel value)
  (let ([pascal (strcase->pascal value)])
    (if (equal? pascal "")
        ""
        (string-append (string-downcase (substring pascal 0 1))
                       (substring pascal 1 (string-length pascal))))))

(define (strcase->screaming-snake value)
  (string-upcase (strcase->snake value)))

(define (strcase->title value)
  (join-with (map capitalize-word (strcase-words value)) " "))

(define (strcase->smart-case-upper value)
  (apply string-append (map smart-case-word (strcase-words value))))

(define (strcase->smart-case-lower value)
  (let ([words (strcase-words value)])
    (if (null? words)
        ""
        (string-append (string-downcase (car words))
                       (apply string-append (map smart-case-word (cdr words)))))))
