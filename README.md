# Inline Vim Footnotes for Markdown

This plugin is designed to support the insertion of inline footnotes of the sort supported by pandoc. By "inline" footnotes, I mean multi-paragraph footnotes placed within the body of the text, rather than endnotes inserted at the end of the document. This plugin was inspired by `vim-markdownfootnotes`, which supports only endnotes.

It defines no mappings by default, but makes available the command `<Plug>AddInlineFootnote` for the user to map, e.g.:

```
nmap <buffer> <Leader>f <Plug>AddInlineFootnote
```
