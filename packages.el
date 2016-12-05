;;; packages.el --- fishman layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <timebomb@saucelulz>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `fishman-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `fishman/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `fishman/pre-init-PACKAGE' and/or
;;   `fishman/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst fishman-packages
  '(
    names
    mpv
    ; (mpv :location local)
    ;; org-glossary
    ;; org-ref
    (org-wiki :location (recipe :fetcher github :repo "caiorss/org-wiki"))
    (ox-cv :location (recipe :fetcher github :repo "mylese/ox-cv"))
    (org-jira :location (recipe :fetcher github :repo "baohaojun/org-jira" :branch "restapi"))
    (ox-jekyll-subtree :location (recipe :fetcher github :repo "Malabarba/ox-jekyll-subtree"))
    calfw
    org-gcal
    ))

(defvar fishman-excluded-packages '() "List of packages to exclude.")

(defun fishman/init-org-wiki ()
  (use-package org-wiki))

;; (defun fishman/init-org-ref ()
  ;; (use-package org-ref))

(defun fishman/init-org-glossary ()
  (use-package org-glossary))

(defun fishman/init-org-wiki ()
  (use-package org-wiki))

(defun fishman/init-ox-cv ()
  (use-package ox-cv))

(defun fishman/init-mpv ()
  (use-package mpv
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'org-mode "mv" "mpv")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "vp" 'mpv-pause
        "vi" 'mpv-insert-playback-position
        "vsi" 'mpv-speed-increase
        "vsp" 'mpv-speed-decrease
        "vq" 'mpv-kill
        )
      )
    ))

(defun fishman/init-names ()
  (use-package names))

(defun fishman/init-org-jira ()
  (use-package org-jira
    :defer t
    :config
    (progn
      (spacemacs/declare-prefix-for-mode 'org-mode "mj" "jira")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjp" "projects")
      (spacemacs/declare-prefix-for-mode 'org-mode "mji" "issues")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjs" "subtasks")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjc" "comments")
      (spacemacs/declare-prefix-for-mode 'org-mode "mjt" "todos")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "jpg" 'org-jira-get-projects
        "jib" 'org-jira-browse-issue
        "jig" 'org-jira-get-issues
        "jih" 'org-jira-get-issues-headonly
        "jif" 'org-jira-get-issues-from-filter-headonly
        "jiF" 'org-jira-get-issues-from-filter
        "jiu" 'org-jira-update-issue
        "jiw" 'org-jira-progress-issue
        "jir" 'org-jira-refresh-issue
        "jic" 'org-jira-create-issue
        "jik" 'org-jira-copy-current-issue-key
        "jsc" 'org-jira-create-subtask
        "jsg" 'org-jira-get-subtasks
        "jcu" 'org-jira-update-comment
        "jtj" 'org-jira-todo-to-jira)
      )
    ))
(defun fishman/init-calfw ()
  (use-package calfw
    :init
    (require 'calfw-org)
    (require 'calfw-cal)
    (require 'calfw-ical)
    (setq calendar-week-start-day 1)
    (setq mark-diary-entries-in-calendar t)
    (setq diary-entry-marker (quote diary-face))
    (setq european-calendar-style 't)
    (setq calendar-latitude 53.55)
    (setq calendar-longitude 9.99)
    (setq european-calendar-style t)
    (setq calendar-location-name "Hamburg, Germany")
    (setq calendar-time-zone 60)
    (setq calendar-standard-time-zone-name "GMT+1")
    (setq calendar-daylight-time-zone-name "GDT")
    (setq calendar-christian-all-holidays-flag t)
    (setq calendar-mark-holidays-flag t)
    (setq calendar-time-display-form
          '(24-hours ":" minutes (and time-zone (concat " (" time-zone ")"))))
    (setq general-holidays
          '((holiday-fixed 1 1 "Neujahr")
            (holiday-fixed 5 1 "1. Mai")
            (holiday-fixed 10 3 "Tag der Deutschen Einheit")))

    (setq christian-holidays
          '(
            (holiday-float 12 0 -4 "1. Advent" 24)
            (holiday-float 12 0 -3 "2. Advent" 24)
            (holiday-float 12 0 -2 "3. Advent" 24)
            (holiday-float 12 0 -1 "4. Advent" 24)
            (holiday-fixed 12 25 "1. Weihnachtstag")
            (holiday-fixed 12 26 "2. Weihnachtstag")
            (holiday-fixed 1 6 "Heilige Drei Knige")
            (holiday-easter-etc 0 "Ostersonntag")
            (holiday-easter-etc 1 "Ostermontag")
            (holiday-easter-etc +49 "Pfingstsonntag")
            (holiday-easter-etc +50 "Pfingstmontag")
            (holiday-fixed 8 15 "Mari Himmelfahrt")
            (holiday-fixed 11 1 "Allerheiligen")
            (holiday-float 11 3 1 "Bu- und Bettag" 16)
            (holiday-float 11 0 1 "Totensonntag" 20)))

    (setq calendar-holidays
          (append general-holidays holiday-other-holidays holiday-local-holidays
                  christian-holidays holiday-solar-holidays))
    ))

; (defun fishman/init-ox-jekyll-subtree ()
;   (use-package ox-jekyll-subtree))

(defun fishman/init-org-gcal ()
  (use-package org-gcal
    :config
    (defun org-gcal--notify (title mes)
      (message "org-gcal::%s - %s" title mes))))
;;; packages.el ends here
