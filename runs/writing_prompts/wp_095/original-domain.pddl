(define (domain haunted-swing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (dead ?character - character)
    (pushing-swing ?character - character)
    (talking ?character1 - character ?character2 - character)
    (sleeping ?character - character)
    (scared ?character - character)
    (murdered ?victim - character ?killer - character)
  )

  ;; A character starts pushing the swing.
  (:action start-pushing-swing
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (pushing-swing ?character)))
    :effect
      (pushing-swing ?character)
    :agents
      (?character)
  )

  ;; A character stops pushing the swing.
  (:action stop-pushing-swing
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (pushing-swing ?character))
    :effect
      (not (pushing-swing ?character))
    :agents
      (?character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (talking ?character1 ?character2)))
    :effect
      (talking ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character stops talking to another character.
  (:action stop-talking
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (talking ?character1 ?character2))
    :effect
      (not (talking ?character1 ?character2))
    :agents
      (?character1)
  )

  ;; A character falls asleep.
  (:action sleep
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (sleeping ?character)))
    :effect
      (sleeping ?character)
    :agents
      (?character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (sleeping ?character))
    :effect
      (not (sleeping ?character))
    :agents
      (?character)
  )

  ;; A character becomes scared.
  (:action become-scared
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (scared ?character)))
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (and (not (alive ?character))
      (dead ?character))
    :agents
      (?character)
  )
)