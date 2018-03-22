;;; redshift.el --- Emacs interface to Redshift

;; Copyright © 2018 Oleg Pykhalov <go.wigust@gmail.com>

;; Author: Oleg Pykhalov <go.wigust@gmail.com>
;; Version: 0.0.1
;; URL: https://wigust.github.io/emacs-redshift/
;; Keywords: tools
;; Package-Requires: ((emacs "24.3")

;; This file is part of Emacs-Redshift.

;; Emacs-Redshift is free software; you can redistribute it
;; and/or modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.
;;
;; Emacs-Redshift is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with Emacs-Redshift.
;; If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file provides functions to control Redshift.  It allows you:
;;
;; - to decrease a display temperature with `redshift-decrease-temp';
;;
;; - to increase a display temperature with `redshift-increase-temp';
;;
;; - to set a display temperature with `redshift-set-temp'.

;;; Code:

(defvar redshift-temp 5500 "Display color temperature")

(defcustom redshift-temp-increment 500
  "Display color temperature increment."
  :type 'number
  :group 'redshift)

(defcustom redshift-program "redshift"
  "The name by which to invoke Redshift."
  :type 'string
  :group 'redshift)

;;;###autoload
(defun redshift-set-temp (temp)
  "Set display color temperature of display to TEMP and return TEMP."
  (interactive "nColor temperature: ")
  (and (start-process "redshift" nil redshift-program
                      "-O" (number-to-string temp))
       temp))

;;;###autoload
(defun redshift-increase-temp ()
  "Increase display color temperature of display to TEMP."
  (interactive)
  (setq redshift-temp
        (redshift-set-temp (+ redshift-temp
                              redshift-temp-increment))))

;;;###autoload
(defun redshift-decrease-temp ()
  "Decrease display color temperature of display to TEMP."
  (interactive)
  (setq redshift-temp
        (redshift-set-temp (- redshift-temp
                              redshift-temp-increment))))

(provide 'redshift)

;;; redshift.el ends here
