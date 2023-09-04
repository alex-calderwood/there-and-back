(define (domain rolling-on-couch)
  (:requirements :strips :typing)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (dizzy ?person - person)
    (loves ?person - person ?object - object)
  )

  ;; A person rolls on the couch.
  (:action roll-on-couch
    :parameters
      (?person - person ?couch - object)
    :precondition
      (and (at ?person ?couch)
      (loves ?person ?couch))
    :effect
      (and (not (at ?person ?couch))
      (dizzy ?person))
  )

  ;; A person lies down on the couch.
  (:action lie-down-on-couch
    :parameters
      (?person - person ?couch - object)
    :precondition
      (and (at ?person ?couch)
      (loves ?person ?couch)
      (dizzy ?person))
    :effect
      (not (dizzy ?person))
  )
)