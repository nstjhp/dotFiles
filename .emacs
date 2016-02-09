(fset 'insertPound
   "#")
(global-set-key (kbd "M-3") 'insertPound);;ALT+3
(global-set-key (kbd "M-4") 'comment-region);;ALT+4
(global-set-key (kbd "M-5") 'uncomment-region);;ALT+5
(setq initial-scratch-message "")
(setq inhibit-startup-screen t)
(setq default-tab-width 4)
(setq c-basic-offset 4)
(global-set-key (kbd "TAB") 'self-insert-command)
(setq indent-tabs-mode nil) 
(add-hook 'makefile-mode-hook 'indent-tabs-mode)
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
;; Draw tabs with the same color as trailing whitespace
;; http://adamrosenfield.com/blog/2009/07/03/spaces-and-tabs/
(add-hook 'font-lock-mode-hook
  '(lambda ()
    (font-lock-add-keywords
      nil
        '(("\t" 0 'trailing-whitespace prepend))
    )
  )
)
(global-set-key (kbd "C-S-k") 'kill-whole-line);;CTRL+SHIFT+K
(global-set-key [home] 'beginning-of-buffer)
(global-set-key [end] 'end-of-buffer) 
(global-linum-mode 1);;shows line number on left
(column-number-mode 1);;shows column number above minibuffer
(global-visual-line-mode 1);;uses visual lines not logical lines
(add-hook 'LaTeX-mode-hook 'adaptive-wrap-prefix-mode);;keeps indentation of long lines
;; http://stackoverflow.com/questions/13559061/emacs-how-to-keep-the-indentation-level-of-a-very-long-wrapped-line
(electric-indent-mode 1);;indent the current line and new ones when you type certain “electric” characters
(add-hook 'python-mode-hook
#'(lambda () (setq electric-indent-mode nil)));;turn it off for Python
(global-hl-line-mode 1 );; highlights the current line
(set-scroll-bar-mode 'left);;scroll-bar on left
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
                                           nil
                                           'fullboth)))
(global-set-key [(control meta return)] 'toggle-fullscreen);;ALT+RETURN =full screen editing
(setq ispell-program-name "aspell");;might not work with flyspell
(setq ispell-local-dictionary "british")
(add-hook 'LaTeX-mode-hook 'flyspell-mode);;picks up spelling errors as you go - middle mouse on word for options
(add-hook 'LaTeX-mode-hook 'flyspell-buffer)
(setq TeX-PDF-mode t);;use PDF as default, not DVI
(add-hook 'doc-view-mode-hook 'auto-revert-mode);;for being clever with viewing PDFs as the source is compiled in another window
;;(add-hook 'LaTeX-mode-hook 'turn-on-auto-fill);;inserts linebreaks automatically
(delete-selection-mode 1);;insert over highlighted text when you type
(add-hook 'LaTeX-mode-hook 'abbrev-mode 1);;use abbrev mode in Latex (lets you type a string that is auto-replaced by sth else eg flora becomes floral transition)
(setq abbrev-file-name             ;; tell emacs where to read abbrev
        "~/.emacs.d/abbrev_defs")    ;; definitions from...
(setq save-abbrevs t)              ;; save abbrevs when files are saved
(setq frame-title-format "%b - emacs");;set the title bar to show buffer name 
(setq make-backup-files nil) ;; stope those annoying file.extension~ files being made
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
 (normal-top-level-add-subdirs-to-load-path))
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist));;use octave mode for all .m files
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1);;use abbrev mode in octave
            (auto-fill-mode 1)));;use auto-fill mode in octave
;;Use XeLaTeX if it finds usepackage{fontspec} (or mathspec)
;; (defun my-latex-mode-hook ()
;;   (add-to-list 'TeX-command-list
;;                '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t))
;;   (setq TeX-command-default
;;         (save-excursion
;;           (save-restriction
;;             (widen)
;;             (goto-char (point-min))
;;             (let ((re (concat "^\\s-*\\\\usepackage\\(?:\\[.*\\]\\)?"
;;                               "{.*\\<\\(?:font\\|math\\)spec\\>.*}")))
;;               (if (re-search-forward re 3000 t)
;;                   "XeLaTeX"
;;                 "LaTeX"))))))
(setq TeX-engine 'xetex)
(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives
			 '("gnu" . "http://elpa.gnu.org/packages/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
    '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
(require 'rainbow-delimiters) ;;coloured nested brackets
(global-rainbow-delimiters-mode)
(require 'ess-site) ;;Emacs speaks statistics (like an R mode)

;; (require 'ess-font-lock)
;; (ess-font-lock-db)
;; (defun ess-font-lock-wheat ()
;; "Set font-lock colors to Richard Heiberger's wheat color scheme."
;; (interactive)
;; (set-face-foreground 'modeline "Wheat")
;; (set-face-background 'modeline "Sienna")
;; (set-face-foreground 'font-lock-comment-face "Firebrick")
;; (set-face-foreground 'font-lock-function-name-face "Blue")
;; (set-face-foreground 'font-lock-keyword-face "Purple")
;; (if (eq font-lock-reference-face 'font-lock-constant-face )
;; (set-face-foreground 'font-lock-constant-face "Brown")
;; (set-face-foreground 'font-lock-reference-face "Brown"))
;; (set-face-foreground 'font-lock-string-face "VioletRed")
;; (set-face-foreground 'font-lock-type-face "Sienna")
;; (set-face-foreground 'font-lock-variable-name-face "Black"))
;; from http://grokbase.com/t/r/ess-help/107p2ekr7s/ess-customizing-syntax-highlighting
;; change ESS highlighting colours
(add-hook 'ess-mode-hook
'(lambda()
(font-lock-add-keywords nil
'(("\\<\\(if\\|for\\|function\\|return\\)\\>[\n[:blank:]]*(" 1
font-lock-keyword-face) ; must go first to override highlighting below
("\\<\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*(" 1
font-lock-function-name-face) ; highlight function names
;;("[(,][\n[:blank:]]*\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=" 1
("\\([(,]\\|[\n[:blank:]]*\\)\\([.A-Za-z][._A-Za-z0-9]*\\)[\n[:blank:]]*=[^=]" 2
font-lock-reference-face) ;highlight argument names
))
))
(ess-toggle-underscore nil) ;;prevent ess from replacing _ with <-. (Just use = for assignment!)
(setq inferior-R-args "--quiet")

;;Adjusting load-path after updating packages http://www.emacswiki.org/emacs/ELPA
;;To my mind one of the faults of ELPA is that the load path is not updated when new packages are installed. Here is a command that will do it for you:
(defun package-update-load-path ()
  "Update the load path for newly installed packages."
  (interactive)
  (let ((package-dir (expand-file-name package-user-dir)))
    (mapc (lambda (pkg)
            (let ((stem (symbol-name (car pkg)))
		  (version "")
		  (first t)
		  path)
	      (mapc (lambda (num)
		      (if first
			  (setq first nil)
			  (setq version (format "%s." version)))
		      (setq version (format "%s%s" version num)))
		    (aref (cdr pkg) 0))
              (setq path (format "%s/%s-%s" package-dir stem version))
              (add-to-list 'load-path path)))
          package-alist)))
(require 'tabbar)
(tabbar-mode)
(setq tabbar-buffer-groups-function
          (lambda ()
            (list "All")))
(global-set-key [(control tab)] 'tabbar-forward-tab)
(global-set-key [(control shift tab)] 'tabbar-backward-tab) ;; doesn't work for some reason!!?
(require 'hlinum);; Highlights the current line
(hlinum-activate)
(adaptive-wrap-prefix-mode 1);; use adaptive wrapping (remember to start lines with spaces!)

;;;;;;;;;;;;;;;;;;;;;;;
(require 'whitespace);;http://emacsredux.com/blog/2013/05/31/highlight-lines-that-exceed-a-certain-length-limit/
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail));;only highlight beyond line limit
(add-hook 'python-mode-hook 'whitespace-mode)
;; (add-hook 'ess-mode-hook 'whitespace-mode)
;(add-hook 'f90-mode-hook 'whitespace-mode);want this to take 132 instead of 80
; Below works but can't turn off in 'LaTeX-mode locally??
;(global-whitespace-mode +1);; show everywhere
;(setq whitespace-global-modes '(ess-mode python-mode))
;;;;;;;;;;;;;;;;;;;;;;;
(setq scroll-step 1)
(setq scroll-conservatively 5)
(defun delete-backward-line ()
  (interactive)
  (kill-line -0))
(global-set-key [(control backspace)] 'delete-backward-line)
(require 'highlight-indentation);;display indentation guides
(add-hook 'python-mode-hook 'highlight-indentation-mode);;
(fset 'yes-or-no-p 'y-or-n-p);; make y/n suffice for yes/no q
(setq LaTeX-item-indent 0);; Indent \items http://tex.stackexchange.com/questions/152295/emacs-indentation-problem
(autoload 'markdown-mode "markdown-mode" ;; Markdown mode. http://jblevins.org/projects/markdown-mode/ looks helpful
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;; (add-to-list 'auto-mode-alist '("\\.Rmd\\'" . markdown-mode))
(setq markdown-enable-math t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(custom-set-variables
 '(markdown-command "/usr/bin/pandoc"));;adapted from http://stackoverflow.com/a/19740648/3275826 as preview didn't work
;; (setq load-path
;;       (append '("/home/nick/Documents/tmp-testing/polymode/"  "/home/nick/Documents/tmp-testing/polymode/modes")
;;               load-path))
;; (require 'poly-R)
;; (require 'poly-markdown)
;; (require 'sublimity)
;; (require 'sublimity-scroll)
;; (require 'sublimity-map)
;; (setq sublimity-map-size 20)
;; (setq sublimity-map-fraction 0.2)
;; (setq sublimity-map-on-commands
;;       '(previous-line next-line backward-paragraph forward-paragraph
;;                       end-of-defun beginning-of-defun))
;; (sublimity-map-set-delay 1)
;; 
;; Toggle case of letter under point. Like ~ in vi.
;; http://stackoverflow.com/q/20884372/3275826
;;(defun toggle-case-next-letter ()
;;  "Toggles the case of the next letter, then moves the point forward one character"
;;  (interactive)
;;  (let* ((p (point))
;;        (upcased (char-upcasep (buffer-substring-no-properties p (+ 1 p))))
;;        (f (if upcased 'downcase-region 'upcase-region)))
;;    (progn
;;      (funcall f p (+ 1 p))
;;      (forward-char))))
;;(defun char-upcasep (letter)
;;;;  (eq letter (upcase letter)));; only upcases
;;    (eq ?c (downcase ?C))) ;; only downcases
;;  (equal letter (upcase letter)));; seems to do both although answerer suggested
;;(defun toggle-case (c) (if (eq c (downcase c)) (upcase c) (downcase c)))
;; but this didn't seem to work for me (probably I don't know how to use it properly!)
;; Instead found this which works from http://chneukirchen.org/dotfiles/.emacs
;; and adapted to not move backwards to the same character (i.e. it moves forward)
(defun chris2-toggle-case ()
  (interactive)
  (let ((char (following-char)))
    (if (eq char (upcase char))
        (insert-char (downcase char) 1 t)
      (insert-char (upcase char) 1 t)))
  (delete-char 1 nil))
;;  (backward-char))
(global-set-key (kbd "M-#") 'chris2-toggle-case)
(setq sentence-end-double-space nil);; http://stackoverflow.com/q/4754547/3275826 ;; So M-a and M-e work as I'd expect (back/forward sentence)
(show-paren-mode t)
;;;;Rainbow delimeters customisations;;;;;;;;;;;;;;;;;;;;;;;
;; from http://yoo2080.wordpress.com/2013/09/08/living-with-rainbow-delimiters-mode/
(require 'cl-lib)
(defvar my-paren-dual-colors
  '("deep pink" "royal blue"))
(cl-loop
 for index from 1 to rainbow-delimiters-max-face-count
 do
 (set-face-foreground
  (intern (format "rainbow-delimiters-depth-%d-face" index))
  (elt my-paren-dual-colors
       (if (cl-evenp index) 0 1))))
(set-face-attribute 'rainbow-delimiters-unmatched-face nil
                    :foreground 'unspecified
                    :inherit 'error)
(set-face-attribute 'rainbow-delimiters-depth-1-face nil
                    :weight 'bold)
;;;;End rainbow delimeters customisations;;;;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "C-x r v") 'string-insert-rectangle);; Do keys and then a character. like doing Ctrl-v in vi followed by "sth" to get a column of "sth"
(add-hook 'LaTeX-mode-hook 'reftex-mode)
;; (setq reftex-default-bibliography '("~/path/to/file/refs.bib"));; Location on bibliography that emacs will search through for keys
(add-hook 'python-mode-hook
      (lambda ()
        (setq-default indent-tabs-mode nil)
        (setq-default tab-width 4)
        (setq-default python-indent 4)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum-highlight-face ((t (:inherit default :background "deep pink" :foreground "yellow")))))
