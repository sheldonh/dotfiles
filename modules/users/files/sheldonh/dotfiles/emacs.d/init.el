(require 'package)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(unless (package-installed-p 'clojure-mode)
  (package-refresh-contents)
  (package-install 'clojure-mode))

(unless (package-installed-p 'paredit)
  (package-refresh-contents)
  (package-install 'paredit))

(unless (package-installed-p 'nrepl)
  (package-refresh-contents)
  (package-install 'nrepl))

(add-hook 'clojure-mode-hook 'paredit-mode)
