(define (domain afterlife-experience)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (experienced-afterlife ?character - character)
    (in-coma ?character - character)
    (resurrected ?character - character)
    (understands-life ?character - character)
  )

  ;; A character falls and experiences the afterlife.
  (:action fall
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (and (not (alive ?character))
      (experienced-afterlife ?character))
    :agents
      (?character)
  )

  ;; A character is brought back to life.
  (:action resurrect
    :parameters
      (?character - character)
    :precondition
      (and (not (alive ?character))
      (experienced-afterlife ?character))
    :effect
      (and (alive ?character)
      (resurrected ?character)
      (understands-life ?character))
    :agents
      (?character)
  )

  ;; A character goes into a coma.
  (:action enter-coma
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (in-coma ?character)
    :agents
      (?character)
  )

  ;; A character wakes up from a coma.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (in-coma ?character)
    :effect
      (not (in-coma ?character))
    :agents
      (?character)
  )

  ;; A character moves to a new place.
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
)