(define (domain mop-selection)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object mop - item place - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?mop - mop)
    (clean ?mop - mop)
    (pretty ?mop - mop)
    (disgusting ?mop - mop)
    (selected ?mop - mop)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character selects a mop.
  (:action select-mop
    :parameters
      (?character - character ?mop - mop)
    :precondition
      (and (at ?character ?place)
      (has ?character ?mop))
    :effect
      (selected ?mop)
    :agents
      (?character)
  )

  ;; A character receives a mop from a dog.
  (:action receive-mop
    :parameters
      (?character - character ?dog - character ?mop - mop ?place - place)
    :precondition
      (and (at ?character ?place)
      (at ?dog ?place)
      (has ?dog ?mop))
    :effect
      (and (not (has ?dog ?mop))
      (has ?character ?mop))
    :agents
      (?character)
  )
)