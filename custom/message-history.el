;;; Package --- magit commit history

;;; Commentary:

;;; Code:

(require 'helm)

(defgroup message-history
  nil
  "Module for message history"
  :group 'extensions)

(defvar message-history/message-header-prefix "--- "
  "Beginning of the header for defining a message.")

(defvar message-history/message-header-suffix " ---"
  "Ending of the header for defining a message.")

(defcustom message-history/message-history-file "~/.emacs.d/magit.hist"
  "The location of the file to save the history to."
  :type '(string)
  :group 'message-history)

(defun message-history/add (pfile)
  "Insert into the message history buffer file PFILE."
  (push-mark)
  (goto-char (point-min))
  (setq content(buffer-substring 1 (- (re-search-forward "^#") 1)))
  (append-to-file (message-history/format-message content (+ (message-history/get-next-id pfile) 1)) nil pfile)
  (pop-mark)
  )

(defun message-history/insert (pfile pid)
  "Retrieve a previous message from history file PFILE and insert into the current buffer.  Pass PID to identify a message."
  (insert (message-history/get pfile pid))
  )

(defun message-history/show (pfile)
  "List previous messages from PFILE by showing the first line."
  (with-temp-buffer
    (let ((lines))
      (insert-file-contents pfile)
      (setq i 1)
      (setq max (message-history/get-next-id pfile))
      (while (re-search-forward (concat message-history/message-header-prefix "[0-9]+" message-history/message-header-suffix) nil t)
        (forward-line)
        (push (concat (number-to-string (+ (abs (- i max)) 1)) ". " (buffer-substring-no-properties (line-beginning-position) (line-end-position))) lines)
        (setq i (+ i 1))
        )
      lines))
  )

(defun message-history/get (pfile pid)
  "Get text from history in file PFILE with id PID."
  (with-temp-buffer
    (setq realid (+ (abs (- pid (message-history/get-next-id pfile))) 1))
    (insert-file-contents pfile)
    (setq start-idx (+ (re-search-forward
                 (message-history/build-separator realid)
                 nil t) 1))
    (forward-line)
    (setq end-found (re-search-forward
                     (concat message-history/message-header-prefix "[0-9]+" message-history/message-header-suffix) nil t))
    (if end-found 
        (setq end-idx (- end-found
                         (length (message-history/build-separator realid)) 1))
      (setq end-idx (point-max)))
    (buffer-substring start-idx end-idx)
    ))

(defun message-history/build-separator (pid)
  "Create a file sepparator with the id PID."
  (concat message-history/message-header-prefix (number-to-string pid) message-history/message-header-suffix)
  )

(defun message-history/format-message (pmessage pid)
  "This function formats PMESSAGE to a format so it can be persisted.  PID will be the unique pid given to the MESSAGE."
  (concat message-history/message-header-prefix (number-to-string pid) message-history/message-header-suffix "\n"
          pmessage "\n"
          ))

(defun message-history/get-next-id (pfile)
  "Return the next id found in file PFILE."
  (with-temp-buffer
    (insert-file-contents pfile)
    (setq maxnum 0)
    (while (re-search-forward (concat message-history/message-header-prefix "[0-9]+" message-history/message-header-suffix) nil t)
      (setq number (string-to-number (let ((line (match-string 0)))
                                       (substring line (string-match "[0-9]+" line) (match-end 0)
                                                  ))))
      (when (> number maxnum) (setq maxnum number))) ;;; no setq but let in the let if > then x else largest
    maxnum))

(defun message-history/helm-insert (pselection)
  "Helm insert helper function PSELECTION is what is selected in helm."
  (message-history/insert message-history/message-history-file
                          (let ((pstring (string-match "[0-9]+\\." pselection)))
                            (string-to-number (substring pselection 0 (- (match-end 0) 1)))))
  )

(defun message-history/helm-search ()
  "Helper function to call the actual search function with parameter."
  (progn (message "In SEARCH !!!")
  (message-history/show message-history/message-history-file))
  )

(defvar message-history/helm-sources
  (helm-build-sync-source "Message history"
    :candidates (message-history/helm-search)
    :action (lambda (candidate) message-history/helm-insert "%S" candidate)))

(defun message-history/helm ()
  "Bring up a helm interface for the message history."
  (interactive)
  (helm :sources '(message-history/helm-sources)
        :buffer "*helm-message-history*")
  )

(provide 'message-history)
;;; message-history.el ends here
