


I don't find drilling down into subdirectories via plain old :e to be that cumbersome given a decent configuration for tab-completion.

Look into the 'wildmenu' option to have Vim show a list of completions (filenames) in the modeline above the commandline. You can change the 'wildmode' option to further configure the kind of tab-completion Vim will do.

Personally I use :set wildmode=full.

My workflow is like this:

    :cd into the toplevel directory of my project.

    To open file foo/bar/baz:

        Simplest scenario: type :e f<tab>b<tab>b<tab><enter>.

        If there are more than one file starting with b in one of those directories you might have to do a <left> or <right> or another <tab> on the keyboard to jump between them (or type a few more letters to disambiguate).

        Worst-case scenario there are files and directories that share a name and you need to drill down into the directory. In this case tab-complete the directory name and then type *<tab> to drill down.
    Open 2 or 3 windows and open files in all of them as needed.
    Once a file is open in a buffer, don't kill the buffer. Leave it open in the background when you open new files. Just :e a new file in the same window.
    Then, use :b <tab> to cycle through buffers that are already open in the background. If you type :b foo<tab> it will match only against currently-open files that match foo.
