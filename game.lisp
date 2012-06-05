(ql:quickload 'blackthorn)

(defpackage #:game
  (:use :cl :blt :blt-user))

(in-package :game)

(defvar *game-size* #c(640 480))

(defclass test-screen (screen)
  ((game-root
    :initform (make-instance 'component :size *game-size*))
   (game-view
    :initform (make-instance 'component :size *game-size*))))

(defclass test-game (game)
  ((game-root :accessor game-root
              :initarg :game-root
              :initform nil)
   (game-view :accessor game-view
              :initarg :game-view
              :initform nil)
   (test-screen :accessor game-test-screen))
  (:default-initargs 
    :game-root (make-instance 'component :size *game-size*)
    :game-view (make-instance 'component :size *game-size*)))

(defmethod game-init ((game test-game) &key player players &allow-other-keys)
  (declare (ignore player players))
  (setf (game-test-screen game) (make-instance 'test-screen :game game))
  (activate (game-test-screen game))
  (set-caption "Cap1" "Cap2")
  (format t "init~%"))


(defvar *game* (make-instance 'test-game))

(blt-user::main)

