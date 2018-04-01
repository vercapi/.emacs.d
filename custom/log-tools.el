
;;; Commentary

;;; Code:


(defvar log-tools-servers)
(defvar log-tools-url)

(setq log-tools-servers (make-hash-table :test 'equal))

(puthash "utastwlsprod6" (vector "utastwlsprod6a" "utastwlsprod6b" "utastwlsprod6c" "utastwlsprod6d" "utastwlsprod6e") log-tools-servers)
(puthash "utastwlsprod7" (vector "utastwlsprod7a" "utastwlsprod7b" "utastwlsprod7c" "utastwlsprod7d" "utastwlsprod7e") log-tools-servers)
(puthash "utastwlsprod8" (vector "utastwlsprod8a" "utastwlsprod8b" "utastwlsprod8c" "utastwlsprod8d" "utastwlsprod8e") log-tools-servers)

(defun log-tools-open-file-wls-kbvb (server-name  managed-server-name)
  "Effectively open files on machine with SERVER-NAME and for managed server with MANAGED-SERVER-NAME."
  (setq log-tools-url (concat "/ssh:" server-name ":/opt/app/oracle/product/12.2.1/user_projects/domains/urbsfa_prod/servers/" managed-server-name "/logs/" managed-server-name "-diagnostic.log"))
  (find-file-noselect log-tools-url)
  )

(mapc
 (lambda (x)
   (message x)
   (mapc
    (lambda (y)
      (message y)
      (log-tools-open-file-wls-kbvb x y)
      )
    (gethash x log-tools-servers))
   )
 (hash-table-keys log-tools-servers))

;;; log-tools.el ends here
