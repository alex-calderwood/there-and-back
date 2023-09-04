(define (domain rebellion)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character group - object place - location)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (loyal-to ?character - character ?group - group)
    (supports ?group - group ?side - group)
    (has-weapon ?character - character)
    (has-supplies ?group - group)
    (has-trained-men ?group - group)
    (gates-open ?place - place)
    (executed ?character - character)
  )

  ;; A character switches loyalty.
  (:action switch-loyalty
    :parameters
      (?character - character ?from - group ?to - group)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (loyal-to ?character ?from))
    :effect
      (and (not (loyal-to ?character ?from))
      (loyal-to ?character ?to))
    :agents  (?character)
  )

  ;; A group supports another group.
  (:action support
    :parameters
      (?group1 - group ?group2 - group)
    :precondition
      (and (not (= ?group1 ?group2))
      (not (supports ?group1 ?group2)))
    :effect
      (supports ?group1 ?group2)
    :agents  (?group1)
  )

  ;; A character is executed.
  (:action execute
    :parameters
      (?executor - character ?victim - character)
    :precondition
      (and (alive ?executor)
      (alive ?victim))
    :effect
      (and (not (alive ?victim))
      (executed ?victim))
    :agents  (?executor)
  )

  ;; The gates of a place are opened.
  (:action open-gates
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (gates-open ?place)))
    :effect
      (gates-open ?place)
    :agents  (?character)
  )
)