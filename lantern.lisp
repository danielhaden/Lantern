(in-package #:common-lisp-user)

(defpackage #:lantern
  (:use #:clim #:clim-lisp #:clim-tab-layout)
  (:export #:lantern-run))
    
(in-package #:lantern)

;;; PANE CLASSES
(defclass sheet-pane (application-pane)
  ())


(define-application-frame lantern ()
  ((design-entities :accessor entities))
  (:panes
   (list-box :application :height 800 :width 200)
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
