(add-to-list 'load-path "/opt/ros/indigo/share/emacs/site-lisp")
;; or whatever your install space is + "/share/emacs/site-lisp"
(require 'rosemacs-config)

;; Load ros launch files as XML.
(add-to-list 'auto-mode-alist '("\\.launch$" . xml-mode))
