(load-theme 'tango-dark t)
(setq userpath (concat  "~/htdocs/" user-login-name ))
(add-to-list 'load-path (concat userpath "/scripts/emacs"))
(setq phafi-phpunit-config (concat userpath "/tests/phpunit.xml"))

(require 'phafi-autoload)
(defun my-phafi-mode()
  (setq userpath (concat  "~/htdocs/" user-login-name ))

  (if (string-match "cosmozend/" (buffer-file-name))
      (setq phafi-phpunit-config (concat userpath "/cosmogramme/cosmozend/tests/phpunit.xml"))

    (if (string-match "multimedia/" (buffer-file-name))
	(setq phafi-phpunit-config "~/public_html/multimedia/var/www/multimedia/tests/phpunit.xml")

      (if (string-match (concat user-login-name "/websvc/") (buffer-file-name))
	  (setq phafi-phpunit-config (concat userpath "/websvc/tests/phpunit.xml"))

	(if (string-match "websvc/" (buffer-file-name))
	    (setq phafi-phpunit-config "~/htdocs/websvc/tests/phpunit.xml")
	  
	  (if (string-match "storm/" (buffer-file-name))
	      (setq phafi-phpunit-config  (concat userpath "/library/storm/tests/phpunit.xml"))

	    (if (string-match (concat user-login-name "/cosmogramme") (buffer-file-name))
		(setq phafi-phpunit-config (concat userpath "/cosmogramme/tests/phpunit.xml"))

	      (setq phafi-phpunit-config (concat userpath "/tests/phpunit.xml")))
	    )
	  )
	)
      )
    )
  )

(add-hook 'phafi-mode-hook 'my-phafi-mode)

(custom-set-variables
 '(menu-bar-mode nil)
 '(show-paren-mode t))

(setq iswitchb-buffer-ignore '("^ "))

(require 'winner)
(winner-mode)

(require 'uniquify)
(toggle-uniquify-buffer-names)

(iswitchb-mode 't)

(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/smex-3.0")
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "M-[ C") 'windmove-right)
(global-set-key (kbd "M-[ D") 'windmove-left)
(global-set-key (kbd "M-[ a") 'windmove-up)
(global-set-key (kbd "M-[ B") 'windmove-down)
(global-set-key [f8] 'next-error)
(global-set-key [f5] 'ag)
(iswitchb-mode 't)

(custom-set-faces)

(setq geben-dbgp-default-port 9001) 

(defun dump_db(dbname)
  (interactive (list (read-string "DB name: ")))
  (async-shell-command
   (concat "bash dump_db " dbname))
)

