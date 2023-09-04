(define (domain tom-the-cat)
  (:requirements :strips :typing)
  (:types cat toy - object)
  (:predicates
    (awake ?cat - cat)
    (asleep ?cat - cat)
    (has ?cat - cat ?toy - toy)
    (playing ?cat - cat ?toy - toy)
  )

  ;; A cat goes to sleep.
  (:action sleep
    :parameters
      (?cat - cat)
    :precondition
      (awake ?cat)
    :effect
      (and (not (awake ?cat))
      (asleep ?cat))
  )

  ;; A cat wakes up.
  (:action wake-up
    :parameters
      (?cat - cat)
    :precondition
      (asleep ?cat)
    :effect
      (and (not (asleep ?cat))
      (awake ?cat))
  )

  ;; A cat plays with a toy.
  (:action play
    :parameters
      (?cat - cat ?toy - toy)
    :precondition
      (and (awake ?cat)
      (has ?cat ?toy))
    :effect
      (and (not (has ?cat ?toy))
      (playing ?cat ?toy))
  )

  ;; A cat stops playing with a toy.
  (:action stop-playing
    :parameters
      (?cat - cat ?toy - toy)
    :precondition
      (playing ?cat ?toy)
    :effect
      (and (not (playing ?cat ?toy))
      (has ?cat ?toy))
  )
)