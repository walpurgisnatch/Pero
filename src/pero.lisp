(in-package :cl-user)
(defpackage :pero
  (:use :cl)
  (:import-from :pero.utils
   :mkdir
                :merge-dirs)
  (:export :logger-setup
   :write-log
   :write-line-to
   :write-dataset-to))

(in-package :pero)

(defvar *log-files* nil)

(defun log-path (log)
    (cdr (assoc log *log-files*)))

(defun create-log-file (log path)
    (push (cons log path) *log-files*))

(defun logger-setup (dir &rest files)
    (declare (type simple-string dir))
    (progn (mkdir dir)           
           (loop for file in files do
             (let ((log-path (mkdir (cdr file) dir)))
                 (create-log-file (car file) log-path)))))

(defun create-message (msg)
    (declare (type simple-string msg))
    (concatenate 'string "~{" msg "~}"))

(defun write-log (file msg &rest args)
    (declare (type simple-string msg))
    (let ((pathname (log-path file))
          (time (local-time:format-timestring nil (local-time:now) :format '(:day "." :month "." :year)))
          (message (format nil (create-message msg) args)))
        (declare (type simple-string pathname time message))
        (with-open-file (stream pathname :direction :output :if-exists :append :if-does-not-exist :create)
            (write-line (format nil "~&[~a] ~a" time message) stream))))

(defun write-line-to (file line)
    (with-open-file (stream pathname :direction :output :if-exists :append :if-does-not-exist :create)
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
    
