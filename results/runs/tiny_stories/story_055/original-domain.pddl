(define (domain tim-and-grandma)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?place - object)
    (scared ?character - character)
    (bug ?bug - object)
    (scary ?bug - object)
    (outside ?bug - object)
  )

  ;; A character moves a bug outside.
  (:action move-bug-outside
    :parameters
      (?character - character ?bug - object)
    :precondition
      (and (alive ?character)
      (bug ?bug)
      (at ?character ?place)
      (at ?bug ?place))
    :effect
      (and (not (at ?bug ?place))
      (outside ?bug))
    :agents  (?character)
  )

  ;; A character reassures another character.
  (:action reassure
    :parameters
      (?reassurer - character ?reassured - character)
    :precondition
      (and (alive ?reassurer)
      (alive ?reassured)
      (scared ?reassured))
    :effect
      (not (scared ?reassured))
    :agents  (?reassurer)
  )

  ;; A character becomes scared of a bug.
  (:action become-scared
    :parameters
      (?character - character ?bug - object)
    :precondition
      (and (alive ?character)
      (bug ?bug)
      (scary ?bug)
      (at ?character ?place)
      (at ?bug ?place))
    :effect
      (scared ?character)
    :agents  (?character)
  )
)