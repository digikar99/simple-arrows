(defpackage :simple-arrows
  (:use :cl)
  (:export :->
           :-<>))

(in-package :simple-arrows)

(defmacro -> (initial-form &rest forms)
  "Examples:
  CL-USER> (-> 3 (/))
  1/3
  CL-USER> (let ((a 3))
             (-> a (incf) (1+)))
  5"
  (if forms
      (destructuring-bind (first &rest rest) forms
        (macroexpand-1 `(-> (,(car first) ,initial-form ,@(cdr first))
                            ,@rest)))
      initial-form))

;;; To handle nested usage of -<>; see simple-arrows-test.lisp
(defun find-symbol-in-tree (symbol tree) ; using 'string=
  (when tree
    (cond ((listp tree)           
           (or (find-symbol-in-tree symbol (car tree))
               (find-symbol-in-tree symbol (cdr tree))))
          ((and (symbolp tree)
                (string= tree symbol))
           tree)
          (t nil))))

(defmacro -<> (initial-form &body forms)
  "Examples:
  CL-USER> (let ((a 5))
           (-<> a
             (incf <>)
             (+ <> <> (-<> 5 (+ <> <>)))))
  22"
  (if forms
      (let* ((first (find-symbol-in-tree '<> (first forms))))
        (macroexpand-1 `(-<> (let ((,first ,initial-form))
                               ,(first forms))
                          ,@(rest forms))))
      initial-form))
