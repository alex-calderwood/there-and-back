(define (domain jarjar-finn-love)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (in-love ?character1 - character ?character2 - character)
    (accepts-past ?character1 - character ?character2 - character)
    (knows-self ?character - character)
    (sings ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character sings.
  (:action sing
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (sings ?character)
    :agents
      (?character)
  )

  ;; Two characters fall in love.
  (:action fall-in-love
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (alive ?character2))
    :effect
      (in-love ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character accepts another's past.
  (:action accept-past
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (alive ?character1)
      (alive ?character2))
    :effect
      (accepts-past ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character knows themself.
  (:action know-self
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (knows-self ?character)
    :agents
      (?character)
  )
)