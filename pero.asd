(defsystem "pero"
    :version "0.1.0"
    :author "Walpurgisnatch"
    :license "MIT"
    :depends-on ("alexandria"
                 "local-time")
    :components ((:module "src"
                  :serial t                  
                  :components
                  ((:file "utils")
                   (:file "pero"))))
    :description "Logging and text file perations library")
