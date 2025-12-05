(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cua-mode t)
 '(custom-enabled-themes '(tango-dark))
 '(mouse-wheel-mode t)
 '(package-selected-packages '(markdown-mode typescript-mode))
 '(warning-suppress-log-types '((copilot copilot-no-mode-indent)))
 '(xterm-mouse-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package typescript-mode
  :straight (:host github :repo "emacs-typescript/typescript.el" :files ("*.el"))
  :ensure t
  :mode (("\\.ts\\'" . typescript-mode)
         ("\\.tsx\\'" . typescript-mode))
  :config
  (setq typescript-indent-level 2)
  (setq typescript-indent-line nil)
  (setq typescript-auto-indent-flag nil)
  (setq typescript-auto-indent-flag nil)
  (setq typescript-indent-line nil)
  (setq typescript-indent-level 2))
(use-package markdown-mode
  :straight (:host github :repo "jrblevin/markdown-mode" :files ("*.el"))
  :ensure t
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode)
         ("\\.mdx\\'" . gfm-mode))
  :config
  (setq markdown-command "multimarkdown")
  (setq markdown-open-command "open")
  (setq markdown-open-command "xdg-open"))
(use-package drag-stuff
  :straight (:host github :repo "rejeep/drag-stuff.el" :files ("*.el"))
  :ensure t
  :bind (("M-<up>" . drag-stuff-up)
         ("M-<down>" . drag-stuff-down)
         ("M-<left>" . drag-stuff-left)
         ("M-<right>" . drag-stuff-right))
  :config
  (drag-stuff-define-keys)
  (drag-stuff-global-mode t)
  (setq drag-stuff-modifier 'meta)
  (setq drag-stuff-except-modes '(org-mode))
  (setq drag-stuff-commit-changes nil)
  (setq drag-stuff-auto-detect nil))
(drag-stuff-global-mode t)