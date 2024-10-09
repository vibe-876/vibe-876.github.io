(setq pages '("index.org" "blog.org" "prog.org"))

(defun export-page (page)
  (find-file page)
  (org-export-dispatch 4)
  (bury-buffer page))

(defun push-to-github nil
  (magit-stage-changed)
  (magit-commit)
  (magit-push))

(mapcar #'export-page pages)
(push-to-github)
