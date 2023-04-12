(in-package #:common-lisp-user)

(defpackage #:lantern
  (:use #:clim #:clim-lisp #:clim-tab-layout)
  (:export #:lantern-run))
    
(in-package #:lantern)

;; VIEW CLASSES
(defclass members-view (view) ())

(defparameter *members-view* (make-instance 'members-view))

;;; PANE CLASSES
(defclass sheet-pane (application-pane)
  ())

;;; CLASSES
(defclass entity()
  ((%name :initarg :name :accessor name)
   (%description :initarg :description :accessor description)
   (%code :initarg :code :accessor code)))

(defun make-entity (name description code)
  (make-instance 'entity
		 :name name
		 :description description
		 :code code))

(defparameter *entities*
  (list (make-entity "CLIM Application Frame" "A detailed explanation of the McCLIM Application Frame" nil)))

(define-presentation-method present ((object entity) (type entity) stream view &key)
  (declare (ignore view))
  (format stream "test"))

(defun display-main-pane (frame pane)
  (loop for ent in (entities frame)
	do (format pane (name ent))))
  
(define-application-frame lantern ()
  ((%entities :initform *entities* :accessor entities))
  (:panes
   (list-box :application
	     :height 800
	     :width 200
	     :display-function 'display-main-pane)
   (canvas sheet-pane :width 800)
   (interactor :interactor))
  (:layouts
   (default (vertically ()
	      (horizontally ()
		list-box
		canvas)
	      interactor))))
(defun lantern-run ()
  (clim:run-frame-top-level (clim:make-application-frame 'lantern)))

(lantern-run)
