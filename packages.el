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
     pocket-reader
     ;; (mpv :location local)
     ;; (org-ref :location (recipe :fetcher github :repo "jkitchin/org-ref"))
     ;; org-ref
     ;;    org-glossary
     (org-wiki :location (recipe :fetcher github :repo "caiorss/org-wiki"))
     (ox-cv :location (recipe :fetcher github :repo "mylese/ox-cv"))
     ;; (org-jira :location (recipe :fetcher github :repo "ahungry/org-jira"))
     calfw
     org-gcal
     ;; (org-glossary :location (recipe :fetcher github :repo "jagrg/org-glossary"))
     org-eww
     eww-lnum
     (ox-jekyll-subtree :location (recipe :fetcher github :repo "Malabarba/ox-jekyll-subtree"))
     calfw
     org-gcal
     ;; (org-journal :toggle org-enable-org-journal-support)
     hackernews
     ))

(defvar fishman-excluded-packages '() "List of packages to exclude.")

(defun fishman/init-org-wiki ()
  (use-package org-wiki))

;; (defun fishman/init-org-ref ()
  ;; (use-package org-ref))

;; (defun fishman/init-org-glossary ()
;;   (use-package org-glossary))

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
    (setq calendar-week-start-day 1)
    (setq mark-diary-entries-in-calendar t)
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
    ;; (with-eval-after-load 'org
    ;;   (require 'calfw-org)
    ;;   (require 'calfw-cal)
    ;;   (require 'calfw-ical)))

  ))

; (defun fishman/init-ox-jekyll-subtree ()
;   (use-package ox-jekyll-subtree))

(defun fishman/init-org-gcal ()
  (use-package org-gcal
    :config
    (defun org-gcal--notify (title mes)
      (message "org-gcal::%s - %s" title mes))))

;; (defun fishman/init-org-journal ()
;;   (use-package org-journal
;;     :defer t
;;     :commands (org-journal-new-entry org-journal-search-forever)
;;     :init
;;     (progn
;;       (spacemacs/declare-prefix "aoj" "org-journal")
;;       (spacemacs/set-leader-keys
;;         "aojj" 'org-journal-new-entry
;;         "aojs" 'org-journal-search-forever)

;;       (spacemacs/set-leader-keys-for-major-mode 'calendar-mode
;;         "r" 'org-journal-read-entry
;;         "i" 'org-journal-new-date-entry
;;         "n" 'org-journal-next-entry
;;         "p" 'org-journal-previous-entry
;;         "s" 'org-journal-search-forever
;;         "w" 'org-journal-search-calendar-week
;;         "m" 'org-journal-search-calendar-month
;;         "y" 'org-journal-search-calendar-year)

;;       (spacemacs/set-leader-keys-for-major-mode 'org-journal-mode
;;         "j" 'org-journal-new-entry
;;         "n" 'org-journal-open-next-entry
;;         "p" 'org-journal-open-previous-entry))))

(defun fishman/init-eww-lnum ()
  (use-package eww-lnum)
  (use-package org-eww
    :init
    (progn
      ;; (spacemacs/declare-prefix "ab" "eww")
      (spacemacs/set-leader-keys
        "ab" 'eww)
      ;; keybindings are exactly the same as in vimperator unless otherwise stated
      (evil-define-key 'normal eww-mode-map
        "&" 'eww-browse-with-external-browser ;; default in eww-mode
        "a" 'eww-add-bookmark
        "yy" 'eww-copy-page-url
        "f" 'eww-lnum-follow
        "F" 'eww-lnum-universal ;; in vimperator open new tab
        "gu" 'eww-up-url
        "gt" 'eww-top-url
        "f" 'eww-lnum-follow
        "F" 'eww-lnum-universal
        "h" 'eww-back-url ;; H in vimperator, because h is :help, but I think lowercase is better for us
        "l" 'eww-forward-url ;; in vimperator, L is used for consistency, but again I think lower case is nicer for us
        "r" 'eww-reload
        "]]" 'eww-next-url
        "[[" 'eww-previous-url
        )
      (spacemacs/set-leader-keys-for-major-mode 'eww-mode
        "h"     'eww-list-histories
        "ba"    'eww-add-bookmark ;; also "a" in normal state
        "bb"    'eww-list-bookmarks
        "s"     'eww-view-source
        "c"     'url-cookie-list)
     ))
  )

(defun fishman/init-hackernews ()
  (use-package hackernews))

(defun fishman/init-pocket-reader ()
  (use-package pocket-reader
    :init
    (progn
      ;; (spacemacs/set-leader-keys-for-major-mode 'pocket-reader-mode
      (evil-define-key 'normal pocket-reader-mode-map
        "O"   'pocket-reader-open-in-external-browser
        "q"   'quit-window
        "o"   'pocket-reader-open-url)
      ))
  )
;;; packages.el ends here
