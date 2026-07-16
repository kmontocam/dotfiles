; extends
; note: tagged templates like sql`...` are already injected by nvim-treesitter's
; builtin ecma queries; these only cover untagged backtick strings marked with // sql

; // sql
; const q = `...`;
((comment) @_sql
  .
  (lexical_declaration
    (variable_declarator
      value: (template_string
        (string_fragment) @injection.content)))
  (#lua-match? @_sql "^//%s*sql%s*$")
  (#set! injection.language "sql"))

; // sql
; q = `...`;
((comment) @_sql
  .
  (expression_statement
    (assignment_expression
      right: (template_string
        (string_fragment) @injection.content)))
  (#lua-match? @_sql "^//%s*sql%s*$")
  (#set! injection.language "sql"))
