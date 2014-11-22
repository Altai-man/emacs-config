					; CL functions.
(require 'cl)

                                        ; Font settings, tool-bar, scroll-bar and menu is off.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-face-attribute 'default nil :family "Ubuntu" :height 110)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)


                                        ; Package system repo.
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)


                                        ; Replacing yes/no to y/n.
(fset 'yes-or-no-p 'y-or-n-p)
(put 'upcase-region 'disabled nil)


                                        ; Keybinds.
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-x\C-g" 'goto-line)
(global-set-key (kbd "C-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key "\C-x\C-b" 'kpm-list)
(global-set-key "\C-x\o" 'switch-window)


                                        ; Replacing query-replace-regexp to "qrr".
(defalias 'qrr 'query-replace-regexp)


                                        ; Emacs jabber.
(custom-set-variables
 '(jabber-account-list (quote (("name@server.domain" (:password . "password") (:network-server . "server.domain") (:connection-type . ssl))))))

(setq
 jabber-history-enabled t
 jabber-use-global-history nil
 jabber-backlog-number 40
 jabber-backlog-days 30
 )

(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" " notify"
                 libnotify-program "--expire-time=3000" title message))

(defun libnotify-jabber-notify (from buf text proposed-alert)
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if (jabber-muc-sender-p from)
        (notify-send (format "(PM) %s"
                             (jabber-jid-displayname (jabber-jid-user from)))
                     (format "%s: %s" (jabber-jid-resource from) text)))
    (notify-send (format "%s" (jabber-jid-displayname from))
                 text)))

(add-hook 'jabber-alert-message-hooks 'libnotify-jabber-notify)


					; Sessions.
(require 'desktop)
(desktop-save-mode 1)
(defun my-desktop-save ()
  (interactive)
  (if (eq (desktop-owner) (emacs-pid))
      (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)


                                        ; Smex - auto-complete commands.
(require 'smex)
(global-set-key "\C-x\C-m" 'smex)


                                        ; Use firefox for links.
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox-bin")

					; Autopairing.
(require 'flex-autopair)
(flex-autopair-mode 1)

					; Expanding of region.
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)


					; Theme and panel.
(require 'moe-theme)
(require 'main-line)
(moe-dark)


                                        ; Google translate.
(require 'google-translate)
(setq google-translate-default-source-language "en")
(setq google-translate-default-target-language "ru")
(global-set-key "\C-ct" 'google-translate-at-point)
(global-set-key "\C-cT" 'google-translate-query-translate)


                                        ; ido.
(require 'ido)
(ido-mode t)


					; Company and Company backends.
(add-hook 'after-init-hook 'global-company-mode)
(eval-after-load 'company
(progn
  '(add-to-list 'company-backends 'company-anaconda)
  '(add-to-list 'company-backends 'company-c-headers)
  '(add-to-list 'company-backends 'company-irony)
  ))


                                        ; Transpose buffers hotkey.
(defun transpose-buffers (arg)
  (interactive "p")
  (let ((selector (if (>= arg 0) 'next-window 'previous-window)))
    (while (/= arg 0)
      (let ((this-win (window-buffer))
            (next-win (window-buffer (funcall selector))))
        (set-window-buffer (selected-window) next-win)
        (set-window-buffer (funcall selector) this-win)
        (select-window (funcall selector)))
      (setq arg (if (plusp arg) (1- arg) (1+ arg))))))
(global-set-key "\C-x4" 'transpose-buffers)


                                        ; Getting things done.
(defun gtd ()
  (interactive)
  (find-file "~/.org/org/gtd.org") )
(defun gtd-save ()
  (interactive)
  (setq file-name (format "GTD-%s.org"
                          (format-time-string "%Y-%m-%d")))
  (write-file file-name))
                                        ;
(defun gtd-save ()
  (interactive)
  (setq file-name (format "GTD-%s.org"
                          (format-time-string "%Y-%m-%d")))
  (write-file file-name))


					; Mingus player.
(add-to-list 'load-path "~/.emacs.d/mingus")
(require 'mingus)

					; List of installed packages:
;; anaconda-mode
;; color-theme
;; company
;; company-anaconda
;; company-c-headers
;; company-irony
;; dash
;; epl
;; evil-nerd-commenter
;; expand-region
;; f
;; flex-autopair
;; flycheck
;; google-translate
;; idomenu
;; irony
;; jabber
;; json-rpc
;; kpm-list
;; main-line
;; moe-theme
;; php-extras
;; php-mode
;; pkg-info
;; popup
;; rainbow-delimiter
;; s
;; smex
;; switch-window
