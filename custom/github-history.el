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
  (message-history/write-message )
  (append-to-file (message-history/format-message content (message-history/get-next-id)) nil pfile)
  (pop-mark)
  )

(defun message-history/insert (id)
  "Retrieve a preious message from history and insert into the current buffer.  Pass ID to identify a message."
  )

(defun message-history/show (pfile)
  "List previous messages from PFILE by showing the first line."
  (with-temp-buffer
    (let ((lines))
      (insert-file-contents pfile)
      (while (re-search-forward (concat message-history/message-header-prefix "[0-9]+" message-history/message-header-suffix) nil t)
        (forward-line)
        (push (buffer-substring-no-properties (line-beginning-position) (line-end-position)) lines)
        )
      lines))
  )

(defun message-history/get (pfile pid)
  "Get text from history in file PFILE with id PID."
  (with-temp-buffer
    (insert-file-contents pfile)
    (setq start-idx (+ (re-search-forward
                 (message-history/build-separator pid)
                 nil t) 1))
    (forward-line)
    (setq end-found (re-search-forward
                     (concat message-history/message-header-prefix "[0-9]+" message-history/message-header-suffix) nil t))
    (if end-found 
        (setq end-idx (- end-found
                         (length (message-history/build-separator pid)) 1))
      (point-max))
    (buffer-substring start-idx end-idx)
    ))

(defun message-history/build-separator (pid)
  "Create a file sepparator with the id PID."
  (concat message-history/message-header-prefix (number-to-string pid) message-history/message-header-suffix)
  )

(defun message-history/format-message (pmessage pid)
  "This function formats PMESSAGE to a format so it can be persisted.  PID will be the unique pid given to the MESSAGE."
  (concat message-history/message-header-prefix (number-to-string pid) message-history/message-header-suffix "\n"
          pmessage
          message-history/message-header-prefix (number-to-string pid) message-history/message-header-suffix "\n"
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

(defvar message-history/helm-sources
  '((name . "Message history")
    (candidates-process . message-history/show)
    (action . (("insert" . message-history/insert)))
    )
  )

(defun message-history/helm ()
  "Bring up a helm interface for the message history."
  (interactive)
  (helm :sources '(message-history/helm-sources)
        :buffer "*helm-message-history*")
  )

;;; github-history.el ends here
