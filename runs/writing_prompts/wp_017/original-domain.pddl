(define (domain mortimers-life)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object)
  (:predicates
    (awake ?character - character)
    (wearing-pajamas ?animal - animal)
    (on-floor ?character - character)
    (dressed ?character - character)
    (holding ?character - character ?object - object)
    (walking ?character - character ?direction - direction)
    (petting ?character - character ?animal - animal)
    (bites ?animal - animal)
    (owns ?character - character ?animal - animal)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (not (awake ?character))
    :effect
      (awake ?character)
    :agents
      (?character)
  )

  ;; A character dresses.
  (:action dress
    :parameters
      (?character - character)
    :precondition
      (and (awake ?character)
      (on-floor ?character)
      (not (dressed ?character)))
    :effect
      (dressed ?character)
    :agents
      (?character)
  )

  ;; A character pets an animal.
  (:action pet
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (and (awake ?character)
      (dressed ?character)
      (not (bites ?animal)))
    :effect
      (petting ?character ?animal)
    :agents
      (?character)
  )

  ;; A character realizes their life is a joke.
  (:action realize-life-is-a-joke
    :parameters
      (?character - character)
    :precondition
      (awake ?character)
    :effect
      (life-is-a-joke ?character)
    :agents
      (?character)
  )
)