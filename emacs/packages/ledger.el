(use-package ledger-mode
  :config
  (add-hook 'ledger-mode #'yas-minor-mode)
  (define-key ledger-mode-map [C-tab] 'other-window)
  ;; 添加一些常用的报表命令
  (add-to-list 'ledger-reports '("expense" "ledger -f 2021.ledger balance ^expense and not '^Expense:Home:家庭资金池'"))
  (add-to-list 'ledger-reports '("4083" "ledger -f ~/Dropbox/Accounting/2021.ledger register ^Assets:Checking:尾号4083"))
  (add-to-list 'ledger-reports '("公司三餐" "ledger -f ~/Dropbox/Accounting/2021.ledger balance ^expense:food and tag 公司"))
  (add-to-list 'ledger-reports '("19国庆旅游" "ledger -f ~/Dropbox/Accounting/2021.ledger balance ^expense and tag '旅游'"))
  (add-to-list 'ledger-reports '("9月份开支" "ledger -b 09/01 -e 09/30 -f ~/Dropbox/Accounting/2021.ledger balance ^expense"))
  (add-to-list 'ledger-reports '("三餐" "ledger -f ~/Dropbox/Accounting/2021.ledger balance '^Expense:Food:早餐' or '^Expense:Food:午餐' or '^Expense:Food:晚餐'"))
  (add-to-list 'ledger-reports '("三餐明细" "ledger -b 10/07 -f ~/Dropbox/Accounting/2021.ledger register ^Expense:Food"))
  (add-to-list 'ledger-reports '("liabilities" "ledger -f ~/Dropbox/Accounting/2021.ledger register Liabilities"))
  (add-to-list 'ledger-reports '("assets" "ledger -f 2021.ledger balance ^assets and \\( not 公积金 \\) or ^liabilities"))
  (add-to-list 'ledger-reports '("zfb" "ledger -f 2021.ledger register '支付宝'"))
  (add-to-list 'ledger-reports '("账单明细" "ledger -f 2021.ledger register '^Liabilities'"))
  ;; TODO: 用:bind代替
  (define-key ledger-mode-map "\C-clr" 'ledger-report)
  :ensure t)
