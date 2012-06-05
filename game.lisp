(ql:quickload 'blackthorn)

(defpackage #:game
  (:use :cl :blt :blt-user))

(in-package :game)

(defvar *game-size* #c(640 480))

;;; screen
(defclass test-screen (screen)
  ((game-root
    :initform (make-instance 'component :size *game-size*))
   (game-view
    :initform (make-instance 'component :size *game-size*)))
   (:default-initargs :game-sheet (load-sheet #p"testsheet_sunburst.png")))

(defmethod initialize-instance :after ((screen test-screen) &key)
  (make-instance 'sprite :image (make-image :test-background-image)
                         :depth 1 :parent (game-root screen)))

;;; game
(defclass test-game (game)
  ((test-screen :accessor game-test-screen)))

(defmethod game-init :before ((game test-game) &key &allow-other-keys)
  (setf (game-test-screen game) (make-instance 'test-screen :game game))
  (activate (game-test-screen game))
  (format t "early game init complete~%"))

(defmethod game-init ((game test-game) &key &allow-other-keys)
  (set-caption "Cap1" "Cap2")
  (format t "game init complete~%"))

;;; toplevel setup
(defvar *game* (make-instance 'test-game))

(blt-user::main)

