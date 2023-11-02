# jumpToLine

For the basic *goto* command, you can only specify the line number. For example:

    > goto 20
    > goto -1

That is, jump to line 20 and jump to the last line, respectively.

However, for *goto* you cannot tell "jump to 50%", i.e. jump to the middle of the document.

This is what this plugin adds. It works like
*goto*, but you can also use percent values:

    > jump 20
    > jump -1
    > jump 50%

If you want to replace the default *goto* with this one, add the following line to your `bindings.json`:

    "Ctrl-l": "command-edit:jump ",
