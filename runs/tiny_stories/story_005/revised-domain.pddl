(define (domain tim-and-wagon)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (has ?character - character ?object - object)
    (at ?character - character ?location - object)
    (shaking-tree ?character - character)
    (wind-blows)
  )

  ;; A character plays with an object.
  (:action play
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (has ?character ?object))
    :effect
      (and)
    :agents
      (?character)
  )

  ;; A character shakes a tree.
  (:action shake-tree
    :parameters
      (?character - character ?tree - object)
    :precondition
      (and (alive ?character)
      (at ?character ?tree))
    :effect
      (shaking-tree ?character)
    :agents
      (?character)
  )

  ;; A character stops shaking a tree.
  (:action stop-shaking-tree
    :parameters
      (?character - character)
    :precondition
      (shaking-tree ?character)
    :effect
      (not (shaking-tree ?character))
    :agents
      (?character)
  )

  ;; The wind blows an object away.
  (:action wind-blows-object
    :parameters
      (?object - object)
    :precondition
      (wind-blows)
    :effect
      (not (has tim ?object))
  )

  ;; The wind starts blowing.
  (:action start-wind
    :effect
      (wind-blows)
  )

  ;; The wind stops blowing.
  (:action stop-wind
    :precondition
      (wind-blows)
    :effect
      (not (wind-blows))
  )
)