#lang racket

(require rackunit)
(require rackunit/text-ui)

(require "actor.rkt")
(require "world.rkt")
(require "runtime.rkt")

(define test-runtime
  (test-suite
   "Tests file for runtime.rkt file"

   (test-case
    "Test on function runtime-send"
    (let* ([actor1 (concrete-actor "A" '(0 . 1) '() 'ally-ship 20)]
           [actor2 (concrete-actor "B" '(3 . 5) '() 'ally-ship 20)]
           [actor3 (concrete-actor "C" '(1 . 1) '() 'ally-missile 0)]
           [world1 (world (list actor1 actor2 actor3))]
           [messages (list (list '(move 1 2) 'ally-ship) (list '(move 0 2) 'ally-missile) (list '(move 2 2) 'ally-ship))]
           [rt1 (runtime world1 messages 0)]
           [rt2 (runtime-send rt1)])
      (check-true (list-actor? (world-actors world1)))
      (check-equal? (length (actor-mailbox (car (world-actors (runtime-world rt2))))) 2)
      (check-equal? (length (actor-mailbox (caddr (world-actors (runtime-world rt2))))) 1)))

   (test-case
    "Test on function runtime-update"
    (let* ([actor1 (concrete-actor "A" '(1 . 1) '() 'ally-ship 20)]
           [actor2 (concrete-actor "B" '(3 . 5) '() 'ally-missile 0)]
           [world1 (world (list actor1 actor2))]
           [messages (list (list '(move 1 1) 'ally-ship) (list '(move 1 1) 'ally-missile) (list (list 'shoot "-") 'ally-ship))]
           [rt1 (runtime world1 messages 0)]
           [rt2 (runtime-send rt1)]
           [rt3 (runtime-update rt2)])
      (check-true (list-actor? (world-actors world1)))
      (check-equal? (actor-location (cadr (world-actors (runtime-world rt3)))) '(2 . 3))
      (check-equal? (actor-type (cadr (world-actors (runtime-world rt3)))) 'ally-missile)
      (check-equal? (length (world-actors (runtime-world rt3))) 3)
      (check-equal? (runtime-tick rt3) 1)))))

      ;;;    (test-case
;;;     "Test on function runtime-receive"
;;;     (let* ([actor1 (concrete-actor "A" '(0 . 1) '() 'ally-ship)]
;;;            [actor2 (concrete-actor "B" '(3 . 5) '() 'ally-missile)]
;;;            [actor3 (concrete-actor "C" '(1 . 1) '() 'ally-missile)]
;;;            [world1 (world (list actor1 actor2 actor3))]
;;;            [msg1 (list '(move 1 2) 'ally-ship)]
;;;            [msg2 (list '(move 0 2) 'ally-missile)]
;;;            [messages (list (list '(move 1 2) 'ally-ship) (list '(move 0 2) 'ally-missile) (list '(move 2 2) 'ally-ship))]
;;;            [rt1 (runtime world1 '() 0)]
;;;            [rt2 (runtime-receive rt1 messages)])
;;;       (check-true (list-msg? (actor-mailbox actor1)))
;;;       (check-true (list-msg? (actor-mailbox actor2)))
;;;       (check-true (list-actor? (world-actors world1)))
;;;       (check-equal? (length (runtime-messages rt1)) 0)
;;;       (check-equal? (length (runtime-messages rt2)) 3)))
   
;;;    (test-case
;;;     "Test on function runtime-send-key"
;;;     (let* ([actor1 (concrete-actor "A" '(0 . 1) '() 'ally-ship)]
;;;            [actor2 (concrete-actor "B" '(3 . 5) '() 'ally-missile)]
;;;            [actor3 (concrete-actor "C" '(1 . 1) '() 'ally-missile)]
;;;            [world1 (world (list actor1 actor2 actor3))]
;;;            [messages (list (list '(move 1 2) 'ally-ship) (list '(move 0 2) 'ally-missile) (list '(move 2 2) 'ally-ship))]
;;;            [rt1 (runtime world1 messages 0)]
;;;            [rt2 (runtime-receive rt1 (list (list '(move 1 2) 'ally-ship)))]
;;;            [rt3 (runtime-send-key rt2 "s")])
;;;       (check-true (list-msg? (actor-mailbox actor1)))
;;;       (check-true (list-msg? (actor-mailbox actor2)))
;;;       (check-true (list-actor? (world-actors world1)))
;;;       (check-equal? (length (runtime-messages rt1)) 3)
;;;       (check-equal? (length (runtime-messages rt2)) 4)))

(run-tests test-runtime)
