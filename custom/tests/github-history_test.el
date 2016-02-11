;;; Package --- magit commit history tests.

;;; Commentary:

;;; Code:

(load-file "../github-history.el")

(ert-deftest message-history/get-next-id-test ()
  (should (= (message-history/get-next-id "./resources/github-history/test.hist") 2))
  )

(ert-deftest message-history/build-separator-test ()
  (should (string= (message-history/build-separator 1)  "--- 1 ---")))

(ert-deftest message-history/get-test ()
  (should (string= (message-history/get "./resources/github-history/test.hist" 2) "Other messages")))

(ert-deftest message-history/show-test ()
  (should (equal (message-history/show "./resources/github-history/test.hist") '("Other messages" "Some message"))))

;;; github-history_test.el ends here
