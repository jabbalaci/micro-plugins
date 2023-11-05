# closeOthers

Close all the panes except the current one, i.e. close all the other panes.

I asked here (https://github.com/zyedidia/micro/issues/2996) how to do it and [dmaluka](https://github.com/dmaluka) gave a working solution. Thanks!

## Usage

Add the following line to your `bindings.json`:

    "Alt-q": "lua:closeOthers.closeOthers",
