(define (domain rabbit-tail)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types rabbit - object)
  (:predicates
    (scared ?rabbit - rabbit)
    (running ?rabbit - rabbit)
    (has-long-tail ?rabbit - rabbit)
    (found-hole)
  )

  ;; A rabbit starts running.
  (:action start-running
    :parameters (?rabbit - rabbit)
    :precondition (and (not (scared ?rabbit)))
    :effect (and (running ?rabbit))
  )

  ;; A rabbit stops running.
  (:action stop-running
    :parameters (?rabbit - rabbit)
    :precondition (and (running ?rabbit))
    :effect (not (running ?rabbit))
  )

  ;; A rabbit hides in a hole.
  (:action hide
    :precondition (and (running ?rabbit) (not (found-hole)))
    :effect (and (found-hole) (not (running ?rabbit)))
  )
)