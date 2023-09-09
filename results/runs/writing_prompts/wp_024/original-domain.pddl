(define (domain kangaroo-revenge)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (has-knife ?character - character)
    (has-kangaroo ?character - character)
    (has-santa-hat ?character - character)
    (angered ?character - character)
    (stole ?character - character)
  )

  ;; A character steals from another character.
  (:action steal
    :parameters
      (?thief - character ?victim - character)
    :precondition
      (and (not (= ?thief ?victim))
      (alive ?thief)
      (alive ?victim))
    :effect
      (and (stole ?thief ?victim)
      (angered ?victim ?thief))
    :agents
      (?thief)
  )

  ;; A character prepares a kangaroo with a santa hat.
  (:action prepare-kangaroo
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has-kangaroo ?character)
      (has-santa-hat ?character))
    :effect
      (prepared-kangaroo ?character)
    :agents
      (?character)
  )

  ;; A character kills another character with a knife.
  (:action kill-with-knife
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (has-knife ?killer)
      (alive ?victim))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; A character dies from a prepared kangaroo.
  (:action die-from-kangaroo
    :parameters
      (?victim - character ?killer - character)
    :precondition
      (and (alive ?victim)
      (angered ?killer ?victim)
      (prepared-kangaroo ?killer))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )
)