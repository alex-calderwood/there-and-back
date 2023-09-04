(define (domain hide-and-seek)
  (:requirements :strips :typing :equality)
  (:types toy - object dog - character)
  (:predicates
    (at ?toy - toy ?place - object)
    (at ?dog - dog ?place - object)
    (hidden ?toy - toy)
    (found ?toy - toy)
  )

  ;; A toy is moved from one place to another.
  (:action move-toy
    :parameters
      (?toy - toy ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?toy ?from))
    :effect
      (and (not (at ?toy ?from))
      (at ?toy ?to))
  )

  ;; A dog is moved from one place to another.
  (:action move-dog
    :parameters
      (?dog - dog ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?dog ?from))
    :effect
      (and (not (at ?dog ?from))
      (at ?dog ?to))
  )

  ;; A toy is hidden.
  (:action hide-toy
    :parameters
      (?toy - toy ?place - object)
    :precondition
      (and (at ?toy ?place)
      (not (hidden ?toy)))
    :effect
      (hidden ?toy)
  )

  ;; A toy is found.
  (:action find-toy
    :parameters
      (?toy - toy ?place - object)
    :precondition
      (and (at ?toy ?place)
      (hidden ?toy))
    :effect
      (and (not (hidden ?toy))
      (found ?toy))
  )
)