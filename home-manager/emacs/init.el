;; Set custom directory for configuration
(setq custom-config-directory "~/nixos/home-manager/emacs/")

;; Load config.org from the custom directory
(org-babel-load-file
 (expand-file-name "config.org" custom-config-directory))

