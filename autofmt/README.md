# autofmt

Automatically beautifies your source code upon save.

It was inspired by https://github.com/a11ce/micro-autofmt

## Languages

Currently supported languages and their associated formatters:

* **C** (`clang-format`)
* **C#** (`clang-format`)
* **Go** (`go fmt`)
* **Java** (`clang-format`)
* **JSON** (`clang-format`)
* **Lua** (`stylua`)
* **Pascal** (`ptop`)
* **Python** (`ruff`)

Under Manjaro, install these packages with your package manager: `clang`, `ruff`, `stylua`, `fpc`

## Usage

Simply save your file and it will be formatted automatically.

You also get a command for this:

    > fmt
