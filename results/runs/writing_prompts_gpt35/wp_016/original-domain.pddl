(define (domain survivalist)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object item - object)
  (:constants
    house spring-house - item
    solar-panels - item
    batteries candles toilet-paper - item
    garden - item)
  (:predicates
    (has ?character - character ?item - item)
    (alive ?character - character)
    (knows ?character - character ?skill - item)
    (intends ?character - character ?predicate - predicate)
    (teaches ?teacher - character ?student - character ?skill - item)
  )

  ;; A character takes an item from a location.
  (:action take
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (at ?item)
      (not (has ?character ?item)))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character teaches another character a skill.
  (:action teach
    :parameters
      (?teacher - character ?student - character ?skill - item)
    :precondition
      (and (alive ?teacher)
      (alive ?student)
      (has ?teacher ?skill)
      (not (knows ?student ?skill))
      (at ?teacher)
      (at ?student))
    :effect
      (knows ?student ?skill)
    :agents
      (?teacher ?student)
  )

  ;; A character intends to learn a skill.
  (:action learn
    :parameters
      (?character - character ?skill - item)
    :precondition
      (and (alive ?character)
      (not (knows ?character ?skill))
      (intends ?character (alive ?character))
      (intends ?character (has ?character ?skill)))
    :effect
      (knows ?character ?skill)
    :agents
      (?character)
  )

  ;; A character intends to survive.
  (:action survive
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (intends ?character (alive ?character))
    :agents
      (?character)
  )

  ;; A character intends to teach another character a skill.
  (:action intend-to-teach
    :parameters
      (?teacher - character ?student - character ?skill - item)
    :precondition
      (and (alive ?teacher)
      (alive ?student)
      (has ?teacher ?skill)
      (not (knows ?student ?skill))
      (intends ?teacher (alive ?teacher))
      (intends ?teacher (teaches ?teacher ?student ?skill))))
    :effect
      (intends ?student (knows ?student ?skill))
    :agents
      (?teacher ?student)
  )

  ;; A character intends to take an item.
  (:action intend-to-take
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (at ?item)
      (not (has ?character ?item))
      (intends ?character (alive ?character))
      (intends ?character (has ?character ?item))))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character intends to learn a skill.
  (:action intend-to-learn
    :parameters
      (?character - character ?skill - item)
    :precondition
      (and (alive ?character)
      (not (knows ?character ?skill))
      (intends ?character (alive ?character))
      (intends ?character (knows ?character ?skill))))
    :effect
      (knows ?character ?skill)
    :agents
      (?character)
  )

  ;; A character intends to survive.
  (:action intend-to-survive
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (intends ?character (alive ?character))
    :agents
      (?character)
  )
)