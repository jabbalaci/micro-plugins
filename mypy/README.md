# mypy

Runs [mypy](https://www.mypy-lang.org/) on your current Python program.

The result is shown in a splitted terminal.

## Requirements

Make sure that mypy is installed on your system. Under Manjaro,
install the package `mypy` .

You must also have a `mypy.ini` file in your current
directory. Here is an example:

```ini
; Usage:
; mypy --config-file mypy.ini *.py

[mypy]
ignore_missing_imports = True
follow_imports = silent

; functions without any annotation are checked:
check_untyped_defs = True

; strict mode; enables the following flags:
warn_unused_configs = True
; disallow_subclassing_any = True
; disallow_untyped_calls = True
; disallow_untyped_defs = True
; disallow_incomplete_defs = True
; check_untyped_defs = True
no_implicit_optional = True
warn_redundant_casts = True
warn_return_any = True
warn_unused_ignores = True
disallow_untyped_decorators = True
```

## Usage

Just issue this command:

    > mypy

## Credits

The idea to produce the result in a splitted terminal window
was taken from here: https://github.com/lukhof/splitterm
