(define (domain hide-and-seek)
  (:requirements :strips :typing :equality)
  (:types toy - object)
  (:predicates
    (hidden ?toy - toy)
    (found ?toy - toy)
  )

  ;; A toy is hidden in a location.
  (:action hide
    :parameters
      (?toy - toy)
    :precondition
      (not (hidden ?toy))
    :effect
      (hidden ?toy)
  )

  ;; A toy is found.
  (:action find
    :parameters
      (?toy - toy)
    :precondition
      (hidden ?toy)
    :effect
      (and (not (hidden ?toy))
      (found ?toy))
  )
)