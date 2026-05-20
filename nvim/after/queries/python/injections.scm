;; extends

; Inject language into triple-quoted strings preceded by a comment with the language name
;
; Usage:
;   # markdown
;   """
;   # Hello World
;   This is **bold** text
;   """

; assignment: variable = """..."""
(module
  (comment) @injection.language
  .
  (expression_statement
    (assignment
      right: (string
        (string_content) @injection.content)))
  (#gsub! @injection.language "#%s*(.+)" "%1"))

; standalone string: """..."""
(module
  (comment) @injection.language
  .
  (expression_statement
    (string
      (string_content) @injection.content))
  (#gsub! @injection.language "#%s*(.+)" "%1"))
