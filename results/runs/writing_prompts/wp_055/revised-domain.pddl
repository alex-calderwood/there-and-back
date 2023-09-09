(define (domain zombie-apocalypse)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:predicates
    (alive ?character - character)
    (zombie ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (clogged ?place - place)
    (burned ?item - item)
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

  ;; A character burns an item.
  (:action burn
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (burned ?item))
    :agents
      (?character)
  )

  ;; A character becomes a zombie.
  (:action turn-into-zombie
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (and (not (alive ?character))
      (zombie ?character))
    :agents
      (?character)
  )

  ;; A zombie character infects another character.
  (:action infect
    :parameters
      (?zombie - character ?victim - character)
    :precondition
      (and (zombie ?zombie)
      (alive ?victim))
    :effect
      (turn-into-zombie ?victim)
    :agents
      (?zombie)
  )
)