; extends

; # sql
; ...string in any position: assignment, kwarg, positional arg, bare expression,
; or a method call on the string (e.g. """...""".strip()).
; content+interpolation captured together so each string parses as ONE sql document
((comment) @_sql
  .
  [
    (expression_statement
      (assignment
        right: (string
          [
            (string_content)
            (interpolation)
          ]+ @injection.content)))
    (expression_statement
      (string
        [
          (string_content)
          (interpolation)
        ]+ @injection.content))
    (keyword_argument
      value: (string
        [
          (string_content)
          (interpolation)
        ]+ @injection.content))
    (string
      [
        (string_content)
        (interpolation)
      ]+ @injection.content)
    (call
      function: (attribute
        object: (string
          [
            (string_content)
            (interpolation)
          ]+ @injection.content)))
  ]
  (#lua-match? @_sql "^#%s*sql%s*$")
  (#set! injection.language "sql")
  (#set! injection.include-children))

; # markdown
; same shapes as above, injected as markdown
((comment) @_markdown
  .
  [
    (expression_statement
      (assignment
        right: (string
          [
            (string_content)
            (interpolation)
          ]+ @injection.content)))
    (expression_statement
      (string
        [
          (string_content)
          (interpolation)
        ]+ @injection.content))
    (keyword_argument
      value: (string
        [
          (string_content)
          (interpolation)
        ]+ @injection.content))
    (string
      [
        (string_content)
        (interpolation)
      ]+ @injection.content)
    (call
      function: (attribute
        object: (string
          [
            (string_content)
            (interpolation)
          ]+ @injection.content)))
  ]
  (#lua-match? @_markdown "^#%s*markdown%s*$")
  (#set! injection.language "markdown")
  (#set! injection.include-children))
