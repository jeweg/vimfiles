
function! quickdoc#qt()
python << END
import webbrowser
import vim

word = vim.eval("expand('<cword>')")
wb = webbrowser.get('windows-default')
wb.open('https://www.google.com/search?btnI=1&q=site%3Adoc.qt.io%2Fqt-5%2F+{word}'.format(word=word), new=2, autoraise=True)

END
endfunction


function! quickdoc#cmake()
python << END
import webbrowser
import vim

word = vim.eval("expand('<cword>')")
wb = webbrowser.get('windows-default')
# wb.open('https://www.google.com/search?btnI=1&q=site%3Awww.cmake.org%2Fcmake%2Fhelp%2Fv3.2%2F+{word}'.format(word=word), new=2, autoraise=True)
wb.open('https://cmake.org/cmake/help/latest/search.html?q={word}&check_keywords=yes&area=default'.format(word=word), new=2, autoraise=True)

END
endfunction


function! quickdoc#cpp()
python << END
import webbrowser
import vim

word = vim.eval("expand('<cword>')")
wb = webbrowser.get('windows-default')
wb.open('http://en.cppreference.com/mwiki/index.php?title=Special%3ASearch&search={word}&button='.format(word=word), new=2, autoraise=True)

END
endfunction
