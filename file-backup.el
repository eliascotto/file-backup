;;; file-backup.el --- Backup current buffer in a new file -*- lexical-binding: t -*-

;; Copyright (C) 2023  Elia Scotto <eliascotto94@gmail.com>

;; Author: Elia Scotto <eliascotto94@gmail.com>
;; Keywords: extensions, file
;; Version: 1.0
;; URL : https://github.com/elias94/file-backup

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
;; 02111-1307, USA.

;;; Commentary:

;; Extension useful to create backups of your saved buffer.
;; Backup file have the timestamp appended to the buffer file name.

;; To use it, simply put a (require 'file-backup) in your ~/.emacs and
;; run `backup-current-buffer'.

;; You can customise the default backup folder using the variable
;; `file-backup-dir'. Or in alternative the backup folder will be
;; called with the `buffer-name'

;;; Code:

(require 's)

(defvar file-backup-dir nil
  "Directory name for backup. Uses `file-backup-dir-post' otherwise.")

(defvar file-backup-dir-post
  "backup"
  "String to append to the generated dir name. Use `file-backup-dir' if set.")

(defun file-backup-timestamp-str ()
  "Returns the current timestamp as string.
 Semicolons are not suited for all filesystems."
  (s-replace ":" "-" (format-time-string "%Y-%m-%dT%H%M%S")))

(defun file-backup-dir-name (buffer-file)
  "Returns the directory name to use for backup."
  (if (stringp file-backup-dir)
      file-backup-dir
      (let ((name-parts (split-string buffer-file "\\.")))
        (format "%s-%s" (car name-parts) (or file-backup-dir-post "")))))

(defun file-backup-format-filename (buffer-file)
  "Returns the filename with timestamp obtained by the buffer file."
  (let ((name-parts (split-string buffer-file "\\.")))
    (format "%s-%s.%s"
            (car name-parts)
            (file-backup-timestamp-str)
            (cadr name-parts))))

(defun file-backup-current-buffer ()
  "Backup the current buffer into `file-backup-dir-name'."
  (interactive
   (progn
     (if (not buffer-file-name)
         (error "Cannot backup a not saved buffer"))))
  (if (not buffer-file-name)
      (error "Cannot backup a not saved buffer"))
  (let ((buf (current-buffer))
        (dirname (file-backup-dir-name (buffer-name)))
        (filename (file-backup-format-filename (buffer-name))))
    (progn
      ;; If directory doesn't exists, create a new one
      (if (not (file-directory-p dirname))
          (make-directory dirname))
      ;; Save buffer content in a new file
      (with-temp-file (concat dirname "/" filename)
       (with-current-buffer (buffer-name)
         (insert-buffer-substring buf))))))

(provide 'file-backup)
;;; file-backup.el ends here
