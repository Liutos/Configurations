(add-to-list 'load-path "/Users/liutos/Projects/all-the-icons.el/")
(when (display-graphic-p)
  (require 'all-the-icons))

(setq org-agenda-category-icon-alist
      (list
       `("^me$" ,(list (all-the-icons-faicon "user" :height 1.2)))
       `("编程爱好者" ,(list (all-the-icons-material "code" :height 1.2)))
       `("电影" ,(list (all-the-icons-material "movie" :height 1.2)))
       `("家庭" ,(list (all-the-icons-faicon "bed" :height 1.2)))
       `("技术写作" ,(list (all-the-icons-material "publish" :height 1.2)))
       `("漫画" ,(list (all-the-icons-faicon "book" :height 1.2)))
       `("优化电脑使用体验" ,(list (all-the-icons-material "computer" :height 1.2)))
       `("战舰少女" ,(list (all-the-icons-material "games" :height 1.2)))
       `("子女" ,(list (all-the-icons-faicon "child" :height 1.2)))))
