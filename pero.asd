(defsystem "pero"
  :version "0.1.0"
  :author "Walpurgisnatch"
  :license "MIT"
  :depends-on ("alexandria")
  :components ((:module "src"
                :components
                ((:file "pero"))))
  :description "Logging library"
  :in-order-to ((test-op (test-op "pero/tests"))))
