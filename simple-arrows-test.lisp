(defpackage :simple-arrows/test
  (:use :cl :fiveam :simple-arrows))

(in-package :simple-arrows/test)

(def-suite :simple-arrows)
(in-suite :simple-arrows)

(def-test test--> ()
  (is (= (-> 3 (/)) 1/3))
  (is (= (-> 3 (/ 2)) 3/2))
  (is (= (let ((a 3))
           (-> a (incf) (1+)))
         5)))

(def-test test--<> ()
  (is (= (let ((x 3))
           (-<> (incf x)
             (+ <> <>)))
         8))
  ;; Should the below be included? We do introduce a variable in the absence
  ;; of these macros. So, should we give the illusion that we are not
  ;; in the presence of these macros?
  ;; (is (typep (handler-case (-<> 4
  ;;                            (incf <>))
  ;;              (condition (c) c))
  ;;            'condition))
  ;; (is (typep (handler-case (-<> (+ 2 3)
  ;;                            (incf <>))
  ;;              (condition (c) c))
  ;;            'condition))
  (is (= (let ((a 5))
           (-<> a
             (incf <>)
             (+ <> <> (-<> 5 (+ <> <>)))))
         22))
  (is (= (-<> 5
           (+ <> <> (+ <> <>)))
         20)))
