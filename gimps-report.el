;;; gimps-report.el -  Quickly get individual account results from 
;;;                        Mersenne PrimeNet Server

;; Copyright (C) 2002 Sami Salkosuo
;; Author: Sami Salkosuo 
;; Version: 0.1 Wed Sep 18 08:57:14 2002

;; This file is not part of GNU Emacs.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;; Commentary:
;;
;; Get individual account status from GIMPS (The Great Internet Mersenne Prime Search).
;;
;; Installation:
;;
;; Add gimps-report.el to your load path and add
;; (require 'gimps-report)
;; to .emacs
;; Set user id and password in .emacs
;; (setq gimps-report-user-id "someone")
;; (setq gimps-report-password "pwd")
;;
;; This package requires get-url-content.el.
;; 
;; If using gimps-report from behind proxy
;; (setq gimps-report-proxy-host )
;; (setq gimps-report-proxy-port )
;;
;; Usage:
;; M-x gimps-report
;; 

(defvar gimps-report-proxy-host nil
  "HTTP proxy host")

(defvar gimps-report-proxy-port nil
  "HTTP proxy port")

(defvar gimps-report-url "www.mersenne.org/cgi-bin/primenet_report.pl"
  "")

(defvar gimps-report-user-id nil
  "")

(defvar gimps-report-password nil
  "")


(defun gimps-report ()
  "Get individual account status from Mersenne PrimeNet Server"
  (interactive)
  (let (
	(buffer-name "*Mersenne PrimeNet Server - Individual Account Report*")
	(results)
	)

    (setq results (get-url-content 
		   (concat 
		    gimps-report-url
		    "?UserID="
		    gimps-report-user-id
		    "&UserPW="
		    gimps-report-password
		    )
		   gimps-report-proxy-host
		   gimps-report-proxy-port
		   ))
    (setq results (substring results (+ 5 (string-match "

" results)) (string-match "

" results)))
    (get-buffer-create buffer-name)
    (switch-to-buffer buffer-name)
    (erase-buffer)
    (insert results)
    (goto-char 0)
    (setq buffer-read-only t)
    )
  )

(provide 'gimps-report)
