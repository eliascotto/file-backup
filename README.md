# file-backup.el

## Overview

`file-backup.el` is an extension used to backup the current buffer in a new file.

## Usage

Run `backup-current-buffer` in a already saved buffer.

## Installation

Simply put a `(require 'file-backup)` in your `~/.emacs`

## Config

### Directory

You can customise the backup directory name using two alternatives:

1. Explicitly set the directory name using `file-backup-dir`

2. Use a generated directory name getting the buffer file name with `file-backup-dir-post` appended. Default `backup`. Ex: `foo.el` buffer -> `foo-backup` dir

## License

Released under GPLv3.

Copyright &copy; 2023 Elia Scotto
