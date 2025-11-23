(latex_block) @latex.outer

(latex_block
  (latex_span_delimiter) @latex.delimiter) 

((latex_block) @latex.inner
  (#any-lua-match? @latex.inner "^%$[^%$]")
  (#offset! @latex.inner 0 1 0 -1))

((latex_block) @latex.inner
  (#any-lua-match? @latex.inner "^%$%$\n")
  (#offset! @latex.inner 0 2 0 -2))
