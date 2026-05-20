;; extends

; override string highlight on injected content with neutral text color.
; at equal priority, this overrides @string because it's a later pattern,
; while injected language highlights (child tree) still override this.

; inside module or block
(_ (comment) @_lang
  .
  (expression_statement
    (assignment
      right: (string
        (string_content) @markup.raw)))
  (#lua-match? @_lang "^#%s*%a+"))

(_ (comment) @_lang
  .
  (expression_statement
    (string
      (string_content) @markup.raw))
  (#lua-match? @_lang "^#%s*%a+"))

; first statement in body: (function, class, for, while, with, try, else)
(_ (comment) @_lang
  body: (block
    .
    (expression_statement
      (assignment
        right: (string
          (string_content) @markup.raw))))
  (#lua-match? @_lang "^#%s*%a+"))

(_ (comment) @_lang
  body: (block
    .
    (expression_statement
      (string
        (string_content) @markup.raw)))
  (#lua-match? @_lang "^#%s*%a+"))

; first statement in consequence: (if, elif)
(_ (comment) @_lang
  consequence: (block
    .
    (expression_statement
      (assignment
        right: (string
          (string_content) @markup.raw))))
  (#lua-match? @_lang "^#%s*%a+"))

(_ (comment) @_lang
  consequence: (block
    .
    (expression_statement
      (string
        (string_content) @markup.raw)))
  (#lua-match? @_lang "^#%s*%a+"))
