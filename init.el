(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b1791a921c4f38cb966c6f78633364ad880ad9cf36eef01c60982c54ec9dd088" "296dcaeb2582e7f759e813407ff1facfd979faa071cf27ef54100202c45ae7d4" "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac" "cd5f8f91cc2560c017cc9ec24a9ab637451e36afd22e00a03e08d7b1b87c29ca" "b41d0a9413fb0034cea34eb8c9f89f6e243bdd76bccecf8292eb1fefa42eaf0a" "71b688e7ef7c844512fa7c4de7e99e623de99a2a8b3ac3df4d02f2cd2c3215e7" default))
 '(org-agenda-files
   '("/home/abbadon/SecondCritique/org/projects.org" "/home/abbadon/SecondCritique/org/inbox.org" "/home/abbadon/SecondCritique/org/main.org"))
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
(load-theme 'ef-frost t)
(setq org-agenda-files '("~/SecondCritique/org"))
(setq org-startup-indented t)

(require 'package)
(add-to-list 'package-archives
  '("melpa-stable"
     . "https://stable.melpa.org/packages/"))
(package-initialize)

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
	 (file "~/SecondCritique/org/inbox.org")
	 "* TODO %?\n" :empty-lines-before 0)
	("n" "Note" entry
	 (file+headline "~/SecondCritique/org/main.org" "Unfiled")
	 "* %i%?\n")
	("j" "Journal Entry" entry
	 (file+datetree "~/SecondCritique/org/journal.org")
	 "* %U\n%?")))


(setq org-refile-targets '(("~/SecondCritique/org/main.org" :maxlevel . 3)))

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
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
(setq org-todo-keywords '(( sequence "TODO(t)" "STARTED(s)" "WAITING(w)" "DEFERRED(d)" "CANCELLED(c)" "DONE(x)")))
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
  (insert (shell-command-to-string "cd ~/SecondCritique; git pull"))))

(setq latex-run-command "pdflatex")

(setq global-auto-revert-mode t)

(defun open-main ()
  (interactive)
  (with-current-buffer (find-file "~/SecondCritique/org/main.org")))

(global-set-key (kbd "C-=") 'open-main)

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
