# file-backup.el

## Overview

Use `file-backup.el` to backup the current buffer in a new file. Backups file have the timestamp appended to the file name.

## Usage

Run `backup-current-buffer` in an already saved buffer.

## Installation

Add `(require 'file-backup)` to your emacs configuration (`~/.emacs`).

## Config

### Directory

You can customise the directory name for the backup using two alternatives:

1. Explicitly set the directory name using `file-backup-dir`

2. Use a generated directory name getting the buffer file name with `file-backup-dir-post` appended. Default is `backup`. Eg: `foo.el` -> `/foo-backup`

## License

Released under GPLv3.

Copyright &copy; 2023 Elia Scotto
