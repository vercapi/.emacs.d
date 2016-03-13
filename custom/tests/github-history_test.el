;;; Package --- Message history tests.

;;; Commentary:

;;; Code:

(load-file "../message-history.el")

(ert-deftest message-history/get-next-id-test ()
  (should (= (message-history/get-next-id "./resources/github-history/test.hist") 2))
  )

(ert-deftest message-history/get-next-id-init-test ()
  (should (= (message-history/get-next-id "./resources/github-history/empty.hist") 0))
  )

(ert-deftest message-history/build-separator-test ()
  (should (string= (message-history/build-separator 1)  "--- 1 ---")))

(ert-deftest message-history/get-test ()
  (should (string= (message-history/get "./resources/github-history/test.hist" 1) "Other messages\n")))

(ert-deftest message-history/show-test ()
  (should (equal (message-history/show "./resources/github-history/test.hist") '("1. Other messages" "2. Some message"))))

;;; github-history_test.el ends here
