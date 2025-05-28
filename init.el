(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("b1791a921c4f38cb966c6f78633364ad880ad9cf36eef01c60982c54ec9dd088" "296dcaeb2582e7f759e813407ff1facfd979faa071cf27ef54100202c45ae7d4" "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac" "cd5f8f91cc2560c017cc9ec24a9ab637451e36afd22e00a03e08d7b1b87c29ca" "b41d0a9413fb0034cea34eb8c9f89f6e243bdd76bccecf8292eb1fefa42eaf0a" "71b688e7ef7c844512fa7c4de7e99e623de99a2a8b3ac3df4d02f2cd2c3215e7" default))
 '(org-agenda-files nil)
 '(package-selected-packages '(auctex slime ef-themes markdown-mode)))
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
(defun custom-make-backup-file-name ( file )
  (let ((d (file-name-directory file))
        (f (file-name-nondirectory file)))
    (concat d "." f "~")))
(setq make-backup-file-name-function 'custom-make-backup-file-name)

(defun backup-file-name-p ( file )
  (let ((letters (string-to-list (file-name-nondirectory file))))
    (and (> 2 (length letters))
         (equal "." (first letters))
         (equal "~" (last letters)))))

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
	 (file+headline "~/SecondCritique/org/inbox.org" "Tasks")
	 "* TODO %?\n %U" :empty-lines-before 0)
	("e" "Eschaton" entry
	 (file+headline "~/SecondCritique/org/eschaton.org" "Eschaton")
	 "* %i%?\n %U")
	("w" "Waiting" entry
	  (file+headline "~/SecondCritique/org/immanent.org" "Waiting")
	   "* %?\n %U")
	("m" "Meeting" entry
	 (file+headline "~/SecondCritique/org/work/meetings.org" "Meetings")
	 "* %?\n %U")
	("j" "Journal Entry" entry
	 (file+datetree "~/SecondCritique/org/journal.org")
	 "* %U\n%?")))
(setq org-refile-targets '(("~/SecondCritique/org/immanent.org" :level . 1)
			  ("~/SecondCritique/org/eschaton.org" :level . 1)
			  ("~/SecondCritique/org/main.org" :level . 1)))
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "/usr/bin/sbcl")
(setq dired-listing-switches "-agho --group-directories-first")
(local-set-key [3 99] 'org-capture)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq org-hide-emphasis-markers t)
