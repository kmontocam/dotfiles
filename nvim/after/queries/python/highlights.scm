;; extends

; override string highlight on injected content with neutral text color.
; at equal priority, this overrides @string because it's a later pattern,
; while injected markdown highlights (child tree) still override this.
(module
  (comment) @_lang
  .
  (expression_statement
    (assignment
      right: (string
        (string_content) @markup.raw)))
  (#lua-match? @_lang "^#%s*%a+"))

(module
  (comment) @_lang
  .
  (expression_statement
    (string
      (string_content) @markup.raw))
  (#lua-match? @_lang "^#%s*%a+"))
