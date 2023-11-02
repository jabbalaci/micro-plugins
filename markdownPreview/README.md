# markdownPreview

With this I wanted to address this issue: https://github.com/zyedidia/micro/issues/2994

I wrote a plugin that used [wgo](https://github.com/bokwoon95/wgo) for monitoring file changes. Although it worked in
the command-line, it didn't work in micro as expected.

So this is not an actual plugin but a workaround solution
to the problem.

## Problem

You edit a markdown (`.md`) file and you want to preview it
in a splitted pane.

## Solution

This is how I do it:

Open a terminal in a vertical pane. I have a shortcut for
that:

    "Ctrl-t": "command:vsplit,command:term",

Issue this command:

    $ preview FileName.md

Where `FileName.md` is the file you're editing in the other pane.

`preview` is a simple shell script:

```bash
#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "Provide the name of a markdown (.md) file"
    exit 1
fi

wgo -file=$1 clear :: glow $1
```

You need the following:
- put this script (`preview`) in the PATH so you can call it
- install [wgo](https://github.com/bokwoon95/wgo)
- install [glow](https://github.com/charmbracelet/glow)

The markdown file will be rendered in the right pane
and wgo is waiting for file changes. Go back to the left
pane and edit the `.md` file. When you save it, the preview
will be updated.

## Limitations

The preview is not synced with the scroll position.
And  you cannot scroll up in the preview pane.

It is best suited for short markdown files that fit
in one screen.
