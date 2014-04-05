(load-theme 'tango-dark t)
(setq userpath (concat  "~/htdocs/" user-login-name ))
(add-to-list 'load-path (concat userpath "/scripts/emacs"))
(setq phafi-phpunit-config (concat userpath "/tests/phpunit.xml"))

(require 'phafi-autoload)
(defun my-phafi-mode()
  (setq userpath (concat  "~/htdocs/" user-login-name ))
  (if (string-match "cosmogramme" (buffer-file-name))
      (setq phafi-phpunit-config (concat userpath "/cosmogramme/tests/phpunit.xml"))
    (if (string-match "multimedia/" (buffer-file-name))
	(setq phafi-phpunit-config "~/public_html/multimedia/var/www/multimedia/tests/phpunit.xml")

      (if (string-match "websvc/" (buffer-file-name))
	  (setq phafi-phpunit-config "~/public_html/websvc/tests/phpunit.xml")

	(if (string-match "storm/" (buffer-file-name))
	    (setq phafi-phpunit-config  (concat userpath "/library/storm/tests/phpunit.xml"))
	  (setq phafi-phpunit-config (concat userpath "/tests/phpunit.xml"))
	  )
	)
      )
    )
  )

(add-hook 'phafi-mode-hook 'my-phafi-mode)

(defun dump-db(dbname)
  (interactive (list (read-string "DB name: ")))
  (async-shell-command 
   (concat 
    "echo 'drop database if exists " dbname "; create database " dbname "'|mysql -uroot -proot;"
    "ssh webmaster@web.afi-sa.net 'sh ~/dump_db.sh' " dbname "|mysql -uroot -proot " dbname))
)


(custom-set-variables
 '(menu-bar-mode nil)
 '(truncate-lines t)
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
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
