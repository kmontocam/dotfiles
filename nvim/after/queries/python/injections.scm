;; extends

; Inject language into triple-quoted strings preceded by a comment with the language name

; inside module or block (comment is sibling of expression_statement)
(_ (comment) @injection.language
  .
  (expression_statement
    (assignment
      right: (string
        (string_content) @injection.content)))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))

(_ (comment) @injection.language
  .
  (expression_statement
    (string
      (string_content) @injection.content))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))

; first statement in body: (function, class, for, while, with, try, else)
(_ (comment) @injection.language
  body: (block
    .
    (expression_statement
      (assignment
        right: (string
          (string_content) @injection.content))))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))

(_ (comment) @injection.language
  body: (block
    .
    (expression_statement
      (string
        (string_content) @injection.content)))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))

; first statement in consequence: (if, elif)
(_ (comment) @injection.language
  consequence: (block
    .
    (expression_statement
      (assignment
        right: (string
          (string_content) @injection.content))))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))

(_ (comment) @injection.language
  consequence: (block
    .
    (expression_statement
      (string
        (string_content) @injection.content)))
  (#lua-match? @injection.language "^#%s*%a+%s*$")
  (#gsub! @injection.language "#%s*(.+)" "%1"))
