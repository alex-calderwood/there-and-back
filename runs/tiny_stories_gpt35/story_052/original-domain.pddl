(define (domain hungry-kitty)
  (:requirements :strips :typing :negative-preconditions)
  (:types animal - object)
  (:predicates
    (hungry ?animal - animal)
    (has-food ?animal - animal)
    (scared ?animal - animal)
    (heard ?animal - animal)
  )

  ;; An animal moves from one place to another.
  (:action move
    :parameters
      (?animal - animal ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?animal ?from))
    :effect
      (and (not (at ?animal ?from))
      (at ?animal ?to))
  )

  ;; An animal feeds from a container.
  (:action feed
    :parameters
      (?animal - animal ?container - object)
    :precondition
      (and (at ?animal ?container)
      (has-food ?container)
      (hungry ?animal))
    :effect
      (and (not (hungry ?animal))
      (not (has-food ?container)))
  )

  ;; An animal gets scared and hides.
  (:action hide
    :parameters
      (?animal - animal ?from - object ?to - object)
    :precondition
      (and (at ?animal ?from)
      (scared ?animal))
    :effect
      (and (not (at ?animal ?from))
      (at ?animal ?to))
  )

  ;; An animal makes a loud noise.
  (:action make-noise
    :parameters
      (?animal - animal)
    :precondition
      (and (at ?animal ?place)
      (hungry ?animal))
    :effect
      (and (heard ?animal)
      (not (hungry ?animal)))
  )
)