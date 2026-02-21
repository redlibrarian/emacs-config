(setq inhibit-startup-message t)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/"))
(package-initialize)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b1791a921c4f38cb966c6f78633364ad880ad9cf36eef01c60982c54ec9dd088" "296dcaeb2582e7f759e813407ff1facfd979faa071cf27ef54100202c45ae7d4" "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac" "cd5f8f91cc2560c017cc9ec24a9ab637451e36afd22e00a03e08d7b1b87c29ca" "b41d0a9413fb0034cea34eb8c9f89f6e243bdd76bccecf8292eb1fefa42eaf0a" "71b688e7ef7c844512fa7c4de7e99e623de99a2a8b3ac3df4d02f2cd2c3215e7" default))
 '(org-agenda-files
   '("~/SecondCritique/org/main.org"))
 '(package-selected-packages
   '(modus-themes writeroom-mode auctex slime ef-themes markdown-mode))
 '(safe-local-variable-values
   '((eval face-remap-add-relative 'default
	   '(:family "Monospace"))
     (eval face-remap-add-relative 'default
	   '(:family "Monospace" :height 160 :background "yellow")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Ubuntu" :foundry "DAMA" :slant normal :weight regular :height 120 :width normal)))))
 
(add-to-list 'load-path "~/.emacs.d/manual-packages/ef-themes")
;; (load-theme 'ef-frost t)
(load-theme 'modus-operandi t)
(setq org-agenda-files '("~/SecondCritique/org/main.org" "~/SecondCritique/org/house.org" "~/SecondCritique/org/cultural-studies-class.org"))
(setq org-startup-indented t)


;; hidden backup files - i hate seeing them in listings ...
;; prefix with a dot as well as postfix with a tilde
;;(defun custom-make-backup-file-name ( file )
;;  (let ((d (file-name-directory file))
;;        (f (file-name-nondirectory file)))
;;    (concat d "." f "~")))
;;(setq make-backup-file-name-function 'custom-make-backup-file-name)

;;(defun backup-file-name-p ( file )
;;  (let ((letters (string-to-list (file-name-nondirectory file))))
;;    (and (> 2 (length letters))
;;         (equal "." (first letters))
 ;;        (equal "~" (last letters)))))

(defun file-name-sans-versions ( file &optional keep-backups )
  (if (or keep-backups (not (backup-file-name-p file)))
      file
    (let ((d (file-name-directory file))
          (f (file-name-nondirectory file)))
      (let ((letters (string-to-list f)))
        (concat d (subseq letters 1 (- (length f) 1)))))))

(global-visual-line-mode 1)
(global-set-key (kbd "s-<up>") #'beginning-of-buffer)
(global-set-key (kbd "s-<down>") #'end-of-buffer)

(setq org-capture-templates
      '(("t" "Tasks" entry
	 (file+headline "~/SecondCritique/org/main.org" "INBOX")
	 "* TODO %?\n" :empty-lines-before 0)
	("n" "Note" entry
	 (file+headline "~/SecondCritique/org/project-support" "Unfiled")
	 "* %i%?\n")
	("m" "Meeting" entry
	 (file+headline "~/SecondCritique/org/main.org" "Unfiled Meetings")
	 "* %U\n%?")
	("c" "Calendar" entry
	 (file+headline "~/SecondCritique/org/main.org" "CALENDAR")
	 "*** %?\n" :empty-lines-before 0)
	("j" "Journal Entry" entry
	 (file+datetree "~/SecondCritique/org/journal.org")
	 "* %U\n%?")))


(setq org-refile-targets '(("~/SecondCritique/org/main.org" :level . 2)))

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/opt/homebrew/bin/sbcl")
(setq dired-listing-switches "-agho --group-directories-first")
(local-set-key [3 99] 'org-capture)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq org-hide-emphasis-markers t)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

 (setq
   org-default-notes-file "~/SecondCritique/org/main.org"
   initial-buffer-choice org-default-notes-file)

(setq calendar-week-start-day 1)
(setq org-todo-keywords '(( sequence "TODO(t)" "NEXT(n)" "SCHEDULED(s)" "INPROGRESS(i)" "WAITING(w)" "DEFERRED(d)" "CANCELLED(c)" "DONE(x)")))
(setq org-todo-keyword-faces '(("TODO" . "green"), ("DONE" . "blue"), ("WAITING" . "pink")))
(setq org-startup-folded t)
;;(defun set-buffer-to-courier ()
;;  (face-remap-add-relative 'default '(:family "Courier" :height 120)))
;;(add-hook 'calendar-mode-hook 'set-buffer-to-courier)

(setq mac-option-key-is-meta nil
      mac-command-key-is-meta t
      mac-command-modifier 'meta
      mac-option-modifier 'none)

(defun git-commit ()
  (interactive)
  (with-current-buffer (pop-to-buffer "*output*")
  (erase-buffer)
  (insert (shell-command-to-string "cd ~/SecondCritique; git add . ; git commit -m 'Update'; git push origin main"))))

(defun git-pull ()
  (interactive)
  (with-current-buffer (pop-to-buffer "*output*")
  (erase-buffer)
  (insert (shell-command-to-string "cd ~/SecondCritique; git pull")))
  (modi/revert-all-file-buffers))

(setq latex-run-command "pdflatex")

(setq global-auto-revert-mode t)

(defun open-main ()
  (interactive)
  (with-current-buffer (find-file "~/SecondCritique/org/main.org")))

(defun open-config ()
  (interactive)
  (with-current-buffer (find-file "~/emacs-config/init.el")))

(global-set-key (kbd "C-=") 'open-main)
(global-set-key (kbd "C--") 'open-config)



(define-key minibuffer-local-map "\M-s" nil)

;;(setq org-publish-project-alist
;;	     '("Nature Builds No Machines"
;;	       :base-directory "~/SecondCritique/projects/critique-ai"
;;	       :publishing-directory "~/SecondCritique/projects/critique-ai/publish"
;;	       :publishing-function org-latex-publish-to-latex
;;	       :body-only t
;;	       :makeindex t
;;	       ))

(autoload 'zap-up-to-char "misc"
  "Kill up to, but not including ARGth occurrence of CHAR.")
(global-set-key (kbd "M-z") 'zap-up-to-char)

(global-set-key (kbd "M-q") 'org-pandoc-export-to-latex-pdf)

(defun modi/revert-all-file-buffers ()
  "Refresh all open file buffers without confirmation.
Buffers in modified (not yet saved) state in emacs will not be reverted. They
will be reverted though if they were modified outside emacs.
Buffers visiting files which do not exist any more or are no longer readable
will be killed."
  (interactive)
  (dolist (buf (buffer-list))
    (let ((filename (buffer-file-name buf)))
      ;; Revert only buffers containing files, which are not modified;
      ;; do not try to revert non-file buffers like *Messages*.
      (when (and filename
                 (not (buffer-modified-p buf)))
        (if (file-readable-p filename)
            ;; If the file exists and is readable, revert the buffer.
            (with-current-buffer buf
              (revert-buffer :ignore-auto :noconfirm :preserve-modes))
          ;; Otherwise, kill the buffer.
          (let (kill-buffer-query-functions) ; No query done when killing buffer
            (kill-buffer buf)
            (message "Killed non-existing/unreadable file buffer: %s" filename))))))
  (message "Finished reverting buffers containing unmodified files."))
(put 'downcase-region 'disabled nil)

(add-hook 'before-save-hook 'time-stamp)

(bibtex-set-dialect 'biblatex)

;;(setq org-agenda-custom-commands
;;      '(("r" "Reading" tags-todov "+@reading")))

(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)

(with-eval-after-load 'org (global-org-modern-mode))

;; Minimal UI
(package-initialize)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(modus-themes-load-theme 'modus-operandi)

;; Choose some fonts
;; (set-face-attribute 'default nil :family "Iosevka")
;; (set-face-attribute 'variable-pitch nil :family "Iosevka Aile")
;; (set-face-attribute 'org-modern-symbol nil :family "Iosevka")

;; Add frame borders and window dividers
(modify-all-frames-parameters
 '((right-divider-width . 40)
   (internal-border-width . 40)))
(dolist (face '(window-divider
                window-divider-first-pixel
                window-divider-last-pixel))
  (face-spec-reset-face face)
  (set-face-foreground face (face-attribute 'default :background)))
(set-face-background 'fringe (face-attribute 'default :background))

(setq
 ;; Edit settings
 org-auto-align-tags nil
 org-tags-column 0
 org-catch-invisible-edits 'show-and-error
 org-special-ctrl-a/e t
 org-insert-heading-respect-content t

 ;; Org styling, hide markup etc.
 org-hide-emphasis-markers t
 org-pretty-entities t
 org-agenda-tags-column 0
 org-ellipsis "…")

(global-org-modern-mode)

;; set Iosevka font only if it available
;;(defun rag-set-face (frame)
;;  "Configure faces on frame creation"
;;  (select-frame frame)
;;  (if (display-graphic-p)
;;      (progn
;;        (when (member "Iosevka" (font-family-list))
;;          (progn
;;            (set-frame-font "Iosevka-12" nil t))))))
;;(add-hook 'after-make-frame-functions #'rag-set-face)

;; set frame font when running emacs normally
;;(when (member "Iosevka" (font-family-list))
;;  (progn
;;    (set-frame-font "Iosevka-12" nil t)))


;; Use fixed width mode in tables.
(set-face-attribute 'variable-pitch nil :family "DejaVu Serif")
(set-face-attribute 'variable-pitch nil :slant 'italic)
(set-face-attribute 'variable-pitch nil :height 120)
;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
;;(add-hook 'text-mode-hook 'variable-pitch-mode)
(add-hook 'org-mode-hook
(lambda ()
;; Enable fill column indicator
;; (fci-mode t)
;; Turn off line numbering, it makes org so slow
;; (linum-mode -1)
;; Set fill column to 79
(setq fill-column 79)
;; Enable automatic line wrapping at fill column
(auto-fill-mode t)))
(defun my-adjoin-to-list-or-symbol (element list-or-symbol)
(let ((list (if (not (listp list-or-symbol))
(list list-or-symbol)
list-or-symbol)))
(require 'cl-lib)
(cl-adjoin element list)))
(mapc
(lambda (face)
(set-face-attribute
face nil
:inherit
(my-adjoin-to-list-or-symbol
'fixed-pitch
(face-attribute face :inherit))))
(list 'org-code 'org-block 'org-table 'org-date
'org-link 'org-footnote))
