(define (domain friendship-support)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (friend ?a - character ?b - character)
    (needs-help ?character - character)
    (smiling ?character - character)
    (laughing ?character - character)
    (provides-help ?a - character ?b - character)
    (talks-to ?a - character ?b - character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?a - character ?b - character)
    :precondition
      (and (not (= ?a ?b))
      (friend ?a ?b))
    :effect
      (talks-to ?a ?b)
    :agents
      (?a)
  )

  ;; A character provides help to another character.
  (:action provide-help
    :parameters
      (?a - character ?b - character)
    :precondition
      (and (not (= ?a ?b))
      (friend ?a ?b)
      (needs-help ?b)
      (talks-to ?a ?b))
    :effect
      (provides-help ?a ?b)
    :agents
      (?a)
  )

  ;; A character starts smiling.
  (:action start-smiling
    :parameters
      (?character - character ?a - character)
    :precondition
      (and (not (smiling ?character))
      (provides-help ?a ?character))
    :effect
      (smiling ?character)
    :agents
      (?character)
  )

  ;; A character starts laughing.
  (:action start-laughing
    :parameters
      (?character - character ?a - character)
    :precondition
      (and (not (laughing ?character))
      (provides-help ?a ?character))
    :effect
      (laughing ?character)
    :agents
      (?character)
  )
)