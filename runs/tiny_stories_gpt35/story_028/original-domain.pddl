(define (domain lily-room)
  (:requirements :strips :typing)
  (:types object - physical-object book - object)
  (:predicates
    (at ?object - physical-object ?place - object)
    (smells-good ?object - physical-object)
    (organized ?object - physical-object)
    (has ?object - physical-object ?book - book)
  )

  ;; A physical object is moved from one place to another.
  (:action move
    :parameters
      (?object - physical-object ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?object ?from))
    :effect
      (and (not (at ?object ?from))
      (at ?object ?to))
  )

  ;; A physical object is placed on another object.
  (:action place
    :parameters
      (?object - physical-object ?on - object)
    :precondition
      (and (not (= ?object ?on))
      (organized ?on))
    :effect
      (and (not (at ?object ?on))
      (at ?object ?on)))
  
  ;; A physical object is scented.
  (:action scent
    :parameters
      (?object - physical-object)
    :precondition
      (organized ?object)
    :effect
      (smells-good ?object))
  
  ;; A book is added to a physical object.
  (:action add-book
    :parameters
      (?object - physical-object ?book - book)
    :precondition
      (and (organized ?object)
      (not (has ?object ?book))))
    :effect
      (has ?object ?book)
  )
)