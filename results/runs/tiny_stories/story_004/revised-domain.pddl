(define (domain chloe-tomato)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has-seen ?character - character ?item - object)
    (trusts ?character1 - character ?character2 - character)
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

  ;; A character sees an object.
  (:action see
    :parameters
      (?character - character ?item - object)
    :precondition
      (alive ?character)
    :effect
      (has-seen ?character ?item)
    :agents  (?character)
  )

  ;; A character trusts another character.
  (:action trust
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (= ?character1 ?character2)))
    :effect
      (trusts ?character1 ?character2)
    :agents  (?character1)
  )

  ;; A character listens to another character.
  (:action listen
    :parameters
      (?listener - character ?speaker - character)
    :precondition
      (and (alive ?listener)
      (alive ?speaker)
      (not (= ?listener ?speaker))
      (trusts ?listener ?speaker))
    :effect
      (and) ;; No direct effect, but represents listening to advice.
    :agents  (?listener)
  )
)