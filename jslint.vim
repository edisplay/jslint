"" jslint.vim
""
"" Jslint-plugin for vim
""
"" 1. Save this file to directory ~/.vim/
"" 2. Save file jslint.mjs to directory ~/.vim/
"" 3. Add vim command ":source ~/.vim/jslint.vim" to file ~/.vimrc
"" 4. You can now run jslint (via nodejs) with command `:JslintFileAfterSave`
"" 5. You can now run jslint (via nodejs) with key-combo `<Ctrl-S> <Ctrl-J>`

"" this function will jslint the file of current buffer after saving it.
"" before using, please save jslint.mjs to ~/.vim/jslint.mjs, e.g.:
"" curl -L https://www.jslint.com/jslint.mjs > ~/.vim/jslint.mjs
function! JslintFileAfterSave(bang)
    "" save file
    if a:bang == "!" | write! | else | write | endif
    "" jslint file
    let &l:errorformat = "%f:%n:%l:%c:%m"
    let &l:makeprg = " node"
	\ . " \"" . $HOME . "/.vim/jslint.mjs\""
        \ . " \"" . fnamemodify(bufname("%"), ":p") . "\""
        \ . " --mode-vim-plugin"
    silent make! | cwindow | redraw!
endfunction

"" create vim command `:JslintFileAfterSave`
command! -nargs=* -bang JslintFileAfterSave call JslintFileAfterSave("<bang>")

"" map vim key-combo `<Ctrl-S> <Ctrl-J>` to :JslintFileAfterSave
nnoremap <silent> <c-s><c-j> :JslintFileAfterSave <cr>
