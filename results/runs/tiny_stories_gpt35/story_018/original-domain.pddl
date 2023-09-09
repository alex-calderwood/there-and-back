(define (domain daisy-treasure)
  (:requirements :strips :typing :equality :existential-preconditions)
  (:types object - physical-object)
  (:predicates
    (hidden ?object - object)
    (treasure ?object - object)
    (stored ?object - object)
  )

  ;; Daisy finds a hidden object.
  (:action find
    :parameters
      (?object - object)
    :precondition
      (hidden ?object)
    :effect
      (and (not (hidden ?object))
           (treasure ?object))
  )

  ;; Daisy stores a treasure in a secret spot.
  (:action store
    :parameters
      (?object - object)
    :precondition
      (and (treasure ?object)
           (not (stored ?object)))
    :effect
      (stored ?object)
  )
)