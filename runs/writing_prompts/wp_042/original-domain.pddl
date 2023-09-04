(define (domain tamara-vacation)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object drink - item)
  (:predicates
    (at ?character - character ?place - place)
    (drunk ?character - character)
    (has ?character - character ?item - item)
    (night-show ?place - place)
    (vomit-stain ?place - place)
  )

  ;; A character drinks a drink.
  (:action drink
    :parameters
      (?character - character ?drink - drink)
    :precondition
      (and (alive ?character)
      (has ?character ?drink))
    :effect
      (and (drunk ?character)
      (not (has ?character ?drink)))
    :agents
      (?character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (not (at ?character ?place)))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character vomits at a place.
  (:action vomit
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (drunk ?character)
      (at ?character ?place))
    :effect
      (vomit-stain ?place)
    :agents
      (?character)
  )

  ;; A character sobers up.
  (:action sober-up
    :parameters
      (?character - character)
    :precondition
      (drunk ?character)
    :effect
      (not (drunk ?character))
    :agents
      (?character)
  )
)