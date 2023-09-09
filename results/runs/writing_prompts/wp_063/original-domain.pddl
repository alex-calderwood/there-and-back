(define (domain death-calculator)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (locked ?door - object)
    (has ?character - character ?item - object)
    (called-police ?character - character)
    (death-averted ?character - character)
    (follows ?character - character ?officer - character)
  )

  ;; A character locks a door.
  (:action lock-door
    :parameters
      (?character - character ?door - object)
    :precondition
      (and (alive ?character)
      (not (locked ?door)))
    :effect
      (locked ?door)
    :agents
      (?character)
  )

  ;; A character calls the police.
  (:action call-police
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (called-police ?character)
    :agents
      (?character)
  )

  ;; A character follows a military officer.
  (:action follow-officer
    :parameters
      (?character - character ?officer - character)
    :precondition
      (and (alive ?character)
      (alive ?officer))
    :effect
      (follows ?character ?officer)
    :agents
      (?character)
  )

  ;; A character averts their death.
  (:action avert-death
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (called-police ?character)
      (follows ?character ?officer))
    :effect
      (death-averted ?character)
    :agents
      (?character)
  )
)