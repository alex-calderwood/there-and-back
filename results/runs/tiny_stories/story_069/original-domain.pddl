(define (domain toy-box)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object toy - item)
  (:predicates
    (has ?character - character ?item - item)
    (fighting ?toy - toy)
    (opened-box ?character - character)
    (with-mom ?character - character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?talker - character ?listener - character)
    :precondition
      (and (not (= ?talker ?listener))
      (alive ?talker)
      (alive ?listener))
    :effect
      (and)
    :agents
      (?talker ?listener)
  )

  ;; A character opens the toy box.
  (:action open-box
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (opened-box ?character)
    :agents
      (?character)
  )

  ;; A character starts a toy fight.
  (:action start-fight
    :parameters
      (?character - character ?toy - toy)
    :precondition
      (and (alive ?character)
      (has ?character ?toy)
      (opened-box ?character))
    :effect
      (fighting ?toy)
    :agents
      (?character)
  )

  ;; A character stops a toy fight.
  (:action stop-fight
    :parameters
      (?character - character ?toy - toy)
    :precondition
      (and (alive ?character)
      (has ?character ?toy)
      (fighting ?toy))
    :effect
      (not (fighting ?toy))
    :agents
      (?character)
  )

  ;; A character goes back to their mom.
  (:action go-to-mom
    :parameters
      (?character - character ?mom - character)
    :precondition
      (and (not (= ?character ?mom))
      (alive ?character)
      (alive ?mom))
    :effect
      (with-mom ?character ?mom)
    :agents
      (?character)
  )
)