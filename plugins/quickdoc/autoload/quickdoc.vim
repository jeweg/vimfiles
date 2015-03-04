
function! quickdoc#qt()
python << END
import webbrowser

#http://vimdoc.sourceforge.net/htmldoc/if_pyth.html#python-vim
import vim

word = vim.eval("expand('<cword>')")
wb = webbrowser.get('windows-default')
wb.open('https://www.google.com/search?btnI=1&q=site%3Adoc.qt.io%2Fqt-5%2F+{word}'.format(word=word), new=2, autoraise=True)

END
endfunction

