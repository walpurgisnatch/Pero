(in-package :cl-user)
(defpackage :pero
  (:use :cl)
  (:import-from :pero.utils
                :mkdir
                :merge-dirs
                :mklist)
  (:export :logger-setup
           :write-log
           :write-line-to
           :write-dataset-to))

(in-package :pero)

(defvar *log-files* nil)
(defvar *log-templates* nil)

(defun create-template (log template) 
  (push (cons log template) *log-templates*))

(defun create-log-file (log path)
  (push (cons log path) *log-files*))

(defun log-path (log)
  (cdr (assoc log *log-files*)))

(defun template-string (template)
  (caddr (assoc template *log-templates*)))

(defun logger-setup (dir &rest templates)
  (declare (type simple-string dir))
  (progn (mkdir dir)           
         (loop for template in templates do
           (parse-template dir template))))

(defun parse-template (dir templates)
  (let ((log-path (mkdir (car templates) dir)))
    (loop for template in (cdr templates) do
      (progn 
        (create-log-file (car template) log-path)
        (create-template (car template) (cdr template))))))

(defun create-message (template args &key custom)
  (let ((message (or custom (template-string template))))
    (if args        
        (format nil (concatenate 'string "~{" message "~}") args)
        message)))

(defun write-log (template &rest args)
  (let ((pathname (log-path template))
        (time (local-time:format-timestring nil (local-time:now) :format '(:day "." :month "." :year " " :hour ":" :min)))
        (message (create-message template args))
        (type (cadr template)))
    (declare (type simple-string pathname time message))
    (with-open-file (stream pathname :direction :output :if-exists :append :if-does-not-exist :create)
      (write-line (format nil "~&[~a] ~a ~a" time type message) stream))))

(defun write-line-to (file line)
  (with-open-file (stream file :direction :output :if-exists :append :if-does-not-exist :create)
    (write-line line stream)))

(defun write-dataset-to (file &key hashvalue hashtable list (if-exists 'supersede))
  (declare (optimize (speed 3) (safety 2))
           (type simple-string file))
  (with-open-file (output file :direction :output :if-exists if-exists :if-does-not-exist :create)
    (cond (hashvalue
           (maphash #'(lambda (key value) (declare (ignorable key))
                        (write-line value output)) hashvalue))
          (hashtable
           (maphash #'(lambda (key value) (write-line (format nil "~&~a: ~a" key value) output)) hashtable))
          (list
           (loop for item in list do
             (write-line item output)))
          (t nil))))
    
