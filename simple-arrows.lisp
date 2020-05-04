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

(defparameter *blacklisted-roots* '(-<>))
;;; To handle nested usage of -<>; see simple-arrows-test.lisp
(defun replace-symbol-in-tree (symbol replacement tree)
  (when tree
    (cond ((and (listp tree) (member (car tree) *blacklisted-roots*))
           tree)
          ((listp tree)           
           (cons (replace-symbol-in-tree symbol replacement (car tree))
                 (replace-symbol-in-tree symbol replacement (cdr tree))))
          ((and (symbolp tree)
                (string= tree symbol))
           replacement)
          (t tree))))

(defmacro -<> (initial-form &body forms)
  "Examples:
  CL-USER> (let ((a 5))
           (-<> a
             (incf <>)
             (+ <> <> (-<> 5 (+ <> <>)))))
  22"
  (if forms
      (let* ((first (gensym))
             (replaced-first (replace-symbol-in-tree '<> first (first forms))))
        (macroexpand-1 `(-<> (let ((,first ,initial-form))
                               ,replaced-first)
                          ,@(rest forms))))
      initial-form))
