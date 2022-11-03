(in-package :cl-user)
(defpackage :pero.templates
  (:use :cl)
  (:export :current-time
           :basic))

(in-package :pero.templates)

(defun current-time ()
  (local-time:format-timestring nil (local-time:now) :format '(:day "." :month "." :year " " :hour ":" :min)))

(defun basic ()
  (list "log" '(:error "ERROR ~a") '(:simple "~a")))
