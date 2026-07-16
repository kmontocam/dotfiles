; extends

; # sql
; definition="""..."""
((comment) @_sql
  .
  (keyword_argument
    value: (string
      (string_content) @injection.content))
  (#lua-match? @_sql "^#%s*sql%s*$")
  (#set! injection.language "sql"))

; # sql
; query = """..."""
((comment) @_sql
  .
  (expression_statement
    (assignment
      right: (string
        (string_content) @injection.content)))
  (#lua-match? @_sql "^#%s*sql%s*$")
  (#set! injection.language "sql"))
