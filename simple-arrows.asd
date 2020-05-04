(asdf:defsystem "simple-arrows"
  :version "0.1.0"
  :author "Shubhamkar B. Ayare"
  :description "Implements the -> and -<> arrow macros"
  :serial t
  :components ((:file "simple-arrows"))
  :in-order-to ((asdf:test-op (asdf:test-op "simple-arrows/test"))))

(asdf:defsystem "simple-arrows/test"
  :depends-on ("simple-arrows" "fiveam")
  :serial t
  :components ((:file "simple-arrows-test"))
  :defsystem-depends-on ("fiveam")
  :perform (asdf:test-op (c v) (uiop:symbol-call "FIVEAM" "RUN" :SIMPLE-ARROWS)))

