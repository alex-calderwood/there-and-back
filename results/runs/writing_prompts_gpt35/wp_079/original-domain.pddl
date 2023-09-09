(define (domain sword-of-truth)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (intends ?character - character ?predicate - predicate)
    (trusts ?character - character ?character2 - character)
    (married ?character - character ?character2 - character)
    (ruling ?place - place)
    (happy ?character - character)
    (discontent ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character intends to make another character happy.
  (:action make-happy
    :parameters
      (?character - character ?character2 - character)
    :precondition
      (and (alive ?character)
      (alive ?character2)
      (at ?character ?place)
      (married ?character ?character2))
    :effect
      (happy ?character2)
    :agents
      (?character)
  )

  ;; A character intends to quell discontent in a place.
  (:action quell-discontent
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (ruling ?place))
    :effect
      (not (discontent ?character))
    :agents
      (?character)
  )

  ;; A character intends to rule a place.
  (:action rule
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (ruling ?place)
    :agents
      (?character)
  )

  ;; A character intends to trust another character.
  (:action trust
    :parameters
      (?character - character ?character2 - character)
    :precondition
      (and (alive ?character)
      (alive ?character2)
      (at ?character ?place)
      (not (= ?character ?character2)))
    :effect
      (trusts ?character ?character2)
    :agents
      (?character)
  )
)