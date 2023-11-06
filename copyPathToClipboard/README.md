# copyPathToClipboard

Copy the absolute path of the current file to the clipboard.

You get two commands:

    > sp

It means "**s**how **p**ath". It simply displays the
absolute path but it doesn't copy anything to the clipboard.

    > cpc

It stands for "**c**opy **p**ath to **c**lipboard".
It displays the path and it copies the absolute path to the clipboard.

If you use it on an empty buffer, then it works
with the absolute path of the current directory.

## Requirements

It was tested under Linux. It requires the command `xsel` that
you can install with your package manager.
