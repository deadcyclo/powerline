;;; powerline-themes.el --- Themes for Powerline

;; Copyright (C) 2012-2013 Donald Ephraim Curtis
;; Copyright (C) 2013 Jason Milkins
;; Copyright (C) 2012 Nicolas Rougier
;; Copyright (C) 2015 Brendan Johan Lee

;; Author: Donald Ephraim Curtis <dcurtis@milkbox.net>
;; URL: http://github.com/milkypostman/powerline/
;; Version: 2.0
;; Keywords: mode-line

;;; Commentary:
;;
;; Themes for Powerline.
;; Included themes: default, center, center-evil, vim, and nano.
;;

;;; Code:


;;;###autoload
(defun powerline-default-theme ()
  "Setup the default mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
			  (face3 (cond
				  ((string= system-name "nobrelee2")
				   (if active 'powerline-red1 'powerline-red1-inactive))
				  ((string= system-name "gsmblog.net")
				   (if active 'powerline-green1 'powerline-green1-inactive))
				  ((string= system-name "tequila.org")
				   (if active 'powerline-blue1 'powerline-blue1-inactive))
				  (t 
				   (if active 'powerline-yellow1 'powerline-yellow1-inactive))))
			  (face4 (cond
				  ((string= system-name "nobrelee2")
				   (if active 'powerline-red2 'powerline-red2-inactive))
				  ((string= system-name "gsmblog.net")
				   (if active 'powerline-green2 'powerline-green2-inactive))
				  ((string= system-name "tequila.org")
				   (if active 'powerline-blue2 'powerline-blue2-inactive))
				  (t 
				   (if active 'powerline-yellow2 'powerline-yellow2-inactive))))
			  (face5 'powerline-spacer)
			  (face6 (cond
				  ((string= system-name "nobrelee2") 
				   'powerline-spacer-red)
				  ((string= system-name "gsmblog.net") 
				   'powerline-spacer-green)
				  ((string= system-name "tequila.org") 
				   'powerline-spacer-blue)
				  (t 
				   'powerline-spacer-yellow)))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" face3 'l)
                                     (powerline-buffer-size face3 'l)
                                     (powerline-raw mode-line-mule-info face3 'l)
				     (powerline-raw " " face3)
				     ;; TODO: Clock & battery information somewhere?
				     (funcall separator-left face3 face4)
				     (powerline-raw " " face4)
                                     (powerline-buffer-id face4 'l)
				     (powerline-raw " " face4)
				     (funcall separator-left face4 face3)
				     (powerline-wg-number face3 'l)
				     (powerline-wg-name face3 'l)
				     (powerline-raw " " face3)
                                     (funcall separator-left face3 face4)
				     (powerline-major-mode face4 'l)				     
				     (if (null window-system)
					 (powerline-raw (char-to-string #x2605) face4))
				     (powerline-raw " " face4)
				     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format face3 'l))
                                     (powerline-process face4)
				     (funcall separator-left face4 face3)
				     (powerline-minor-modes face3 'l)
                                     (powerline-raw " " face3)
                                     (funcall separator-left face3 face4)
                                     ;(powerline-narrow face1 'l)
                                     ;(powerline-raw " " face1)
                                     ;(funcall separator-left face1 face2)
				     ;; TODO: LOOK AT VC - See if I can add dirty working directory symbol
                                     (powerline-vc face4 'r)
				     (funcall separator-left face4 face5)))
                          (rhs (list (powerline-raw global-mode-string face6 'r)
                                     (funcall separator-right face5 face4)
                                     (if (null window-system)
                                             (powerline-raw (concat " " (char-to-string #xe0a1)) face4))
                                     (powerline-raw "%4l" face4 'l)
                                     (powerline-raw ":" face4 'l)
                                     (powerline-raw "%3c" face4 'r)
                                     (funcall separator-right face4 face3)
                                     (powerline-raw " " face3)
                                     (powerline-raw "%6p" face3 'r)
                                     (powerline-hud face3 face4))))
                     (concat (powerline-render lhs)
                             (powerline-fill face5 (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-center-theme ()
  "Setup a mode-line with major and minor modes centered."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-size nil 'l)
                                     (powerline-buffer-id nil 'l)
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (powerline-narrow face1 'l)
                                     (powerline-vc face1)))
                          (rhs (list (powerline-raw global-mode-string face1 'r)
                                     (powerline-raw "%4l" face1 'r)
                                     (powerline-raw ":" face1)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1)))
                          (center (list (powerline-raw " " face1)
                                        (funcall separator-left face1 face2)
                                        (when (boundp 'erc-modified-channels-object)
                                          (powerline-raw erc-modified-channels-object face2 'l))
                                        (powerline-major-mode face2 'l)
                                        (powerline-process face2)
                                        (powerline-raw " :" face2)
                                        (powerline-minor-modes face2 'l)
                                        (powerline-raw " " face2)
                                        (funcall separator-right face2 face1))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill face1 (powerline-width rhs))
                             (powerline-render rhs)))))))

(defun powerline-center-evil-theme ()
  "Setup a mode-line with major, evil, and minor modes centered."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-raw "%*" nil 'l)
                                     (powerline-buffer-size nil 'l)
                                     (powerline-buffer-id nil 'l)
                                     (powerline-raw " ")
                                     (funcall separator-left mode-line face1)
                                     (powerline-narrow face1 'l)
                                     (powerline-vc face1)))
                          (rhs (list (powerline-raw global-mode-string face1 'r)
                                     (powerline-raw "%4l" face1 'r)
                                     (powerline-raw ":" face1)
                                     (powerline-raw "%3c" face1 'r)
                                     (funcall separator-right face1 mode-line)
                                     (powerline-raw " ")
                                     (powerline-raw "%6p" nil 'r)
                                     (powerline-hud face2 face1)))
                          (center (append (list (powerline-raw " " face1)
                                                (funcall separator-left face1 face2)
                                                (when (boundp 'erc-modified-channels-object)
                                                  (powerline-raw erc-modified-channels-object face2 'l))
                                                (powerline-major-mode face2 'l)
                                                (powerline-process face2)
                                                (powerline-raw " " face2))
                                          (if (split-string (format-mode-line minor-mode-alist))
                                              (append (if evil-mode
                                                          (list (funcall separator-right face2 face1)
                                                                (powerline-raw evil-mode-line-tag face1 'l)
                                                                (powerline-raw " " face1)
                                                                (funcall separator-left face1 face2)))
                                                      (list (powerline-minor-modes face2 'l)
                                                            (powerline-raw " " face2)
                                                            (funcall separator-right face2 face1)))
                                            (list (powerline-raw evil-mode-line-tag face2)
                                                  (funcall separator-right face2 face1))))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill face1 (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-vim-theme ()
  "Setup a Vim-like mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (mode-line (if active 'mode-line 'mode-line-inactive))
                          (face1 (if active 'powerline-active1 'powerline-inactive1))
                          (face2 (if active 'powerline-active2 'powerline-inactive2))
                          (separator-left (intern (format "powerline-%s-%s"
                                                          powerline-default-separator
                                                          (car powerline-default-separator-dir))))
                          (separator-right (intern (format "powerline-%s-%s"
                                                           powerline-default-separator
                                                           (cdr powerline-default-separator-dir))))
                          (lhs (list (powerline-buffer-id `(mode-line-buffer-id ,mode-line) 'l)
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-major-mode mode-line)
                                     (powerline-process mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (buffer-modified-p)
                                       (powerline-raw "[+]" mode-line))
                                     (when buffer-read-only
                                       (powerline-raw "[RO]" mode-line))
                                     (powerline-raw "[%z]" mode-line)
                                     ;; (powerline-raw (concat "[" (mode-line-eol-desc) "]") mode-line)
                                     (when (and (boundp 'which-func-mode) which-func-mode)
                                       (powerline-raw which-func-format nil 'l))
                                     (when (boundp 'erc-modified-channels-object)
                                       (powerline-raw erc-modified-channels-object face1 'l))
                                     (powerline-raw "[" mode-line 'l)
                                     (powerline-minor-modes mode-line)
                                     (powerline-raw "%n" mode-line)
                                     (powerline-raw "]" mode-line)
                                     (when (and vc-mode buffer-file-name)
                                       (let ((backend (vc-backend buffer-file-name)))
                                         (when backend
                                           (concat (powerline-raw "[" mode-line 'l)
                                                   (powerline-raw (format "%s / %s" backend (vc-working-revision buffer-file-name backend)))
                                                   (powerline-raw "]" mode-line)))))))
                          (rhs (list (powerline-raw '(10 "%i"))
                                     (powerline-raw global-mode-string mode-line 'r)
                                     (powerline-raw "%l," mode-line 'l)
                                     (powerline-raw (format-mode-line '(10 "%c")))
                                     (powerline-raw (replace-regexp-in-string  "%" "%%" (format-mode-line '(-3 "%p"))) mode-line 'r))))
                     (concat (powerline-render lhs)
                             (powerline-fill mode-line (powerline-width rhs))
                             (powerline-render rhs)))))))

;;;###autoload
(defun powerline-nano-theme ()
  "Setup a nano-like mode-line."
  (interactive)
  (setq-default mode-line-format
                '("%e"
                  (:eval
                   (let* ((active (powerline-selected-window-active))
                          (lhs (list (powerline-raw (concat "GNU Emacs "
                                                            (number-to-string
                                                             emacs-major-version)
                                                            "."
                                                            (number-to-string
                                                             emacs-minor-version))
                                                    nil 'l)))
                          (rhs (list (if (buffer-modified-p) (powerline-raw "Modified" nil 'r))))
                          (center (list (powerline-raw "%b" nil))))
                     (concat (powerline-render lhs)
                             (powerline-fill-center nil (/ (powerline-width center) 2.0))
                             (powerline-render center)
                             (powerline-fill nil (powerline-width rhs))
                             (powerline-render rhs)))))))


(provide 'powerline-themes)

;;; powerline-themes.el ends here
