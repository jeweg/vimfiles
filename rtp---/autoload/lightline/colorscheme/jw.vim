let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray4'] ]
let s:p.normal.right = [ ['gray5', 'gray10'], ['gray9', 'gray4'], ['gray8', 'gray2'] ]
let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = s:p.inactive.right[1:]
let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'gray4'] ]
let s:p.visual.left = [ ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]

let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]

let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right
let s:p.tabline.left = [ [ 'gray9', 'gray4' ] ]
let s:p.tabline.tabsel = [ [ 'gray9', 'gray1' ] ]
let s:p.tabline.middle = [ [ 'gray2', 'gray8' ] ]
let s:p.tabline.right = [ [ 'gray9', 'gray3' ] ]
let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]





" darker solarized: bg #001f27 fg #3f5f68 | bg #001115 
" greens: bg #94be00 fg #005100 | bg #364800 fg #cbcebf | bg #213500
 
" lightline will use the array elements subsequently to colorize groups.
" If it runs out, it defaults to the middle colors.
let s:p.normal.left = [ ['#005100', '#94be00', 'bold'], ['#cbcebf', '#364800'] ]
let s:p.normal.middle = [ [ '#cbcebf', '#213500' ] ]
let s:p.normal.right = [ ['#005100', '#94be00', 'bold'], ['#cbcebf', '#364800'], ['#65724c', '#213500'], ['#65724c', '#213500'] ]


let s:p.inactive.left = [ [ '#3f5f68', '#001115' ] ]
let s:p.inactive.middle = [ [ '#3f5f68', '#001115' ] ]
let s:p.inactive.right = [ [ '#3f5f68', '#001115' ] ]


let g:lightline#colorscheme#jw#palette = lightline#colorscheme#fill(s:p)
