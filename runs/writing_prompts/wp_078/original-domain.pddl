(define (domain king-koopa)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (married ?character1 - character ?character2 - character)
    (freedom ?place - place)
    (tyrant-defeated)
    (kidnapped ?character - character)
  )

  ;; A character marries another character.
  (:action marry
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (married ?character1 ?character2)))
    :effect
      (married ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character defeats the tyrant.
  (:action defeat-tyrant
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (tyrant-defeated)))
    :effect
      (tyrant-defeated)
    :agents
      (?character)
  )

  ;; A character kidnaps another character.
  (:action kidnap
    :parameters
      (?kidnapper - character ?victim - character)
    :precondition
      (and (alive ?kidnapper)
      (alive ?victim)
      (not (kidnapped ?victim)))
    :effect
      (kidnapped ?victim)
    :agents
      (?kidnapper)
  )

  ;; A character frees a kidnapped character.
  (:action free-kidnapped
    :parameters
      (?rescuer - character ?victim - character)
    :precondition
      (and (alive ?rescuer)
      (alive ?victim)
      (kidnapped ?victim))
    :effect
      (not (kidnapped ?victim))
    :agents
      (?rescuer)
  )

  ;; A character brings freedom to a place.
  (:action bring-freedom
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (freedom ?place)))
    :effect
      (freedom ?place)
    :agents
      (?character)
  )
)