;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory
	      (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")

;; パッケージ管理
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packaeges/"))
(package-initialize)

;; C-mでnewline-and-indent
(define-key global-map (kbd "C-m") 'newline-and-indent)

;; C-hでbackspace
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; C-x ?でhelp
(define-key global-map (kbd "C-x ?") 'help-command)

;; C-tでウィンドウ切替
(define-key global-map (kbd "C-t") 'other-window)

;; C-zでundo
(define-key global-map (kbd "C-z") 'undo)

;; スタートアップスクリーン非表示
(setq inhibit-startup-screen t)

;; フレームサイズ設定
(set-frame-size (selected-frame) 88 48)

;; ツールバーを非表示
(tool-bar-mode 0)

;; ウィンドウ左に行番号を表示
(setq linum-format "%4d")
(global-linum-mode t)

;; モードラインに列番号を表示
(column-number-mode t)

;; モードラインにファイルサイズを表示
(size-indication-mode t)

;; モードラインに時刻を表示
;; (setq display-time-day-and-date t) ; 曜日・月・日を表示
(setq display-time-24hr-format t)     ; 24時間表示
(display-time-mode t)

;; タイトルバーにファイルのフルパスを表示
(setq frame-title-format "%f")

;; タブの表示幅を4に設定
(setq-default tab-width 4)

;; インデントにタブ文字の使用を禁止
(setq-default indent-tabs-mode nil)

;; 対応する括弧を強調して表示
(setq show-paren-delay 0)
(show-paren-mode t)
;; (setq show-paren-style 'expression)
;; (set-face-background 'show-paren-match-face nil)
;; (set-face-underline-p 'show-paren-match-face "white")

;; バックアップファイルの作成場所をシステムのTempディレクトリに変更
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))

;; オートセーブファイルの作成場所をシステムのTempディレクトリに変更
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory)))

;; 更新されたファイルを自動的に再読み込み
;; (global-auto-revert-mode t)

;; Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(setq markdown-command "pandoc -s --self-contained -t html5 -c ~/.pandoc/github-markdown.css")

;; Helm
(require 'helm-config)

;; Flycheck
(add-hook 'after-init-hook #'global-flycheck-mode)
(with-eval-after-load 'flycheck (flycheck-pos-tip-mode))
;; (with-eval-after-load 'flycheck (flycheck-popup-tip-mode))

;; Multi Term
(when (require 'multi-term nil t)
  (setq multi-term-program "/bin/dash"))

;; Auto Complete
(when (require 'auto-complete-config nil t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-use-menu-map t)
  (setq ac-ignore-case nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "#55FF55" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "unknown" :family "Ricty"))))
 '(cursor ((((class color) (background dark)) (:background "#00AA00")) (((class color) (background light)) (:background "#999999")) (t nil))))
;; (set-face-attribute 'default nil
;;                     :family "Ricty"
;;                     :height 120)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (auto-complete multi-term magit flycheck-popup-tip flycheck-pos-tip flycheck markdown-mode sml-mode madhat2r-theme helm color-theme-sanityinc-tomorrow))))
