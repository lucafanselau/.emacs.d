  (require 'dash)

(defun my/ts--get-element-bounds (ts-query )
  (setq captured-nodes (treesit-query-capture (treesit-buffer-root-node) ts-query (point) (point) ))
  

  ;; filter out all nodes of element name
  (setq named-nodes (-filter (lambda (n) (string= (car n)
						  "element")) captured-nodes) ) 
  ;; (message "result: %s" named-nodes)
  (setq bounds (-map (lambda (n) (cons (treesit-node-start (cdr n)) (treesit-node-end (cdr n)))) named-nodes))
  ;; (message "bounds: %s" bounds)
  ;; (setq BEG (-map (lambda (node) (treesit-node-start (cdr node))) result))
  ;; (setq END (-map (lambda (node) (treesit-node-end (cdr node))) result))
  ;; (cons (-first-item BEG) (-first-item END))
  (-last-item bounds)
  )
(defun my/ts--get-element-children (ts-query )
  (setq captured-nodes (treesit-query-capture (treesit-buffer-root-node) ts-query (point) (point) ))
  ;; (message "%s" captured-nodes)
  ;; filter out all nodes of element name
  (setq last-element-index  (-second-item (-find-indices (lambda (n) (string= (car n) "element")) captured-nodes)))
  ;; (message "last index: %s" last-element-index)
  (setq closest-nodes (-slice captured-nodes 0 last-element-index))
  (setq named-nodes (-filter (lambda (n) (string= (car n)
						  "children")) closest-nodes) )
  ;; (message "result: %s" named-nodes)
  (setq bounds (-map (lambda (n) (cons (treesit-node-start (cdr n)) (treesit-node-end (cdr n)))) named-nodes))
  ;; (message "bounds: %s" bounds)
  ;; (setq BEG (-map (lambda (node) (treesit-node-start (cdr node))) result))
  ;; (setq END (-map (lambda (node) (treesit-node-end (cdr node))) result))
  ;; (cons (-first-item BEG) (-first-item END))
  (setq BEG (-min (-map #'car bounds))
	END (-max (-map #'cdr bounds)))
  (cons BEG END)
  )

(let* ((query '([(jsx_element) (jsx_self_closing_element)] @element))
       (inner-query '((jsx_element
		       open_tag: (_)
		       (_)* @children
		       close_tag: (_))  @element)))
  (meow-thing-register 'tag `(lambda () (my/ts--get-element-children ',inner-query )) `(lambda () (my/ts--get-element-bounds ',query )))
  (add-to-list 'meow-char-thing-table '(?t . tag)))
			 

(provide 'treesit-meow)
