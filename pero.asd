(defsystem "pero"
    :version "1.0.0"
    :author "Walpurgisnatch"
    :license "MIT"
    :depends-on ("alexandria"
                 "local-time")
    :components ((:module "src"
                  :serial t                  
                  :components
                  ((:file "utils")
                   (:file "pero"))))
    :description "Logging library"
    :in-order-to ((test-op (test-op "pero/tests"))))
