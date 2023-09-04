(define (domain dog-and-cat)
  (:requirements :strips :typing :equality)
  (:types animal - object)
  (:predicates
    (has-wrap ?animal - animal)
    (at ?animal - animal ?location - object)
    (clean ?wrap - object)
  )

  ;; A character moves from one location to another.
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

  ;; A character takes an object.
  (:action take
    :parameters
      (?animal - animal ?object - object ?location - object)
    :precondition
      (and (at ?animal ?location)
      (at ?object ?location))
    :effect
      (and (not (at ?object ?location))
      (at ?object ?animal)
      (has-wrap ?animal ?object))
  )

  ;; A character drops an object.
  (:action drop
    :parameters
      (?animal - animal ?object - object ?location - object)
    :precondition
      (and (at ?animal ?location)
      (at ?object ?animal)
      (has-wrap ?animal ?object))
    :effect
      (and (not (at ?object ?animal))
      (at ?object ?location)
      (not (has-wrap ?animal ?object))))
  
  ;; A character cleans an object.
  (:action clean-wrap
    :parameters
      (?animal - animal ?wrap - object)
    :precondition
      (and (at ?animal ?location)
      (at ?wrap ?animal)
      (has-wrap ?animal ?wrap))
    :effect
      (clean ?wrap)
  )
)