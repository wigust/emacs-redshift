;;; guix.scm --- Emacs interface to Redshift

;; Copyright © 2018 Oleg Pykhalov <go.wigust@gmail.com>

;; This file is part of Emacs-Redshift.

;; Emacs-Redshift is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of the
;; License, or (at your option) any later version.
;;
;; Emacs-Redshift is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with Emacs-Redshift.
;; If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This file contains Guix package for development version of
;; Emacs-redshift.  To build or install, run:
;;
;;   guix build --file=guix.scm
;;   guix package --install-from-file=guix.scm

;;; Code:

(use-modules ((guix licenses) #:prefix license:)
             (guix build utils)
             (guix build-system emacs)
             (guix gexp)
             (guix git-download)
             (guix packages)
             (ice-9 popen)
             (ice-9 rdelim))

(define %source-dir (dirname (current-filename)))

(define (git-output . args)
  "Execute 'git ARGS ...' command and return its output without trailing
newspace."
  (with-directory-excursion %source-dir
    (let* ((port   (apply open-pipe* OPEN_READ "git" args))
           (output (read-string port)))
      (close-port port)
      (string-trim-right output #\newline))))

(define (current-commit)
  (git-output "log" "-n" "1" "--pretty=format:%H"))

(define emacs-redshift
  (let ((commit (current-commit)))
    (package
      (name "emacs-redshift")
      (version (string-append "0.0.1" "-" (string-take commit 7)))
      (source (local-file %source-dir
                          #:recursive? #t
                          #:select? (git-predicate %source-dir)))
      (build-system emacs-build-system)
      (home-page "https://github.com/wigust/emacs-redshift")
      (synopsis "Emacs interface to Redshift")
      (description
       "This package provides an Emacs interface to Redshift")
      (license license:gpl3+))))

emacs-redshift

;;; guix.scm ends here
