# toggle

This one wasn't written by me but I put it
here for future references.

I found it here: https://github.com/zyedidia/micro/issues/2086 . Author: [dmaluka](https://github.com/dmaluka) .

It provides the following command:

    > toggle

This allows us to toggle the value of a boolean variable.

With this, you can write the following:

    > toggle softwrap

It also has a local version:

    > togglelocal softwrap

Personally, I assigned this to F6 in my `bindings.json`:

    "F6": "command:togglelocal softwrap",
