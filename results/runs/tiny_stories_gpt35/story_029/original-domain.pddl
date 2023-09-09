(define (domain garage-playtime)
  (:requirements :strips :typing :equality)
  (:types object - physical-object)
  (:predicates
    (at ?object - object ?location - object)
    (in-nest ?bird - object)
    (dead ?bird - object)
  )

  ;; A character moves an object from one location to another.
  (:action move
    :parameters
      (?character - object ?object - object ?from - object ?to - object)
    :precondition
      (and (at ?character ?from)
      (at ?object ?from)
      (not (= ?from ?to)))
    :effect
      (and (not (at ?object ?from))
      (at ?object ?to))
    :agents
      (?character)
  )

  ;; A character helps a bird back to its nest.
  (:action help-bird
    :parameters
      (?character - object ?bird - object ?nest - object)
    :precondition
      (and (at ?character ?nest)
      (at ?bird ?nest)
      (dead ?bird))
    :effect
      (and (not (dead ?bird))
      (in-nest ?bird))
    :agents
      (?character)
  )
)