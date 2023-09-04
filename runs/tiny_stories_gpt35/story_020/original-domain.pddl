(define (domain safari-exploration)
  (:requirements :strips :typing :equality)
  (:types animal - object)
  (:predicates
    (at ?animal - animal ?location - object)
    (explored ?location - object)
  )

  ;; An animal moves from one location to another.
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

  ;; An animal explores a location.
  (:action explore
    :parameters
      (?animal - animal ?location - object)
    :precondition
      (and (at ?animal ?location)
      (not (explored ?location)))
    :effect
      (explored ?location)
  )
)