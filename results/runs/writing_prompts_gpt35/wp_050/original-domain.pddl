(define (domain rebellion)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (loyal-to-rebellion ?character - character)
    (loyal-to-crown ?character - character)
    (at ?character - character ?location - object)
    (has-shield ?character - character)
    (has-cloak ?character - character)
    (protects ?character - character ?location - object)
    (executed ?character - character)
  )

  ;; A character travels from one location to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
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

  ;; A character shields another character.
  (:action shield
    :parameters
      (?protector - character ?protectee - character ?location - object)
    :precondition
      (and (alive ?protector)
      (alive ?protectee)
      (at ?protector ?location)
      (at ?protectee ?location)
      (not (= ?protector ?protectee))
      (not (has-shield ?protectee))
      (not (has-cloak ?protectee)))
    :effect
      (and (protects ?protector ?protectee ?location)
      (has-shield ?protectee))
    :agents
      (?protector ?protectee)
  )

  ;; A character is executed.
  (:action execute
    :parameters
      (?character - character ?location - object)
    :precondition
      (and (alive ?character)
      (at ?character ?location)
      (not (loyal-to-rebellion ?character))
      (not (has-cloak ?character))
      (not (has-shield ?character)))
    :effect
      (and (not (alive ?character))
      (executed ?character))
    :agents
      (?character)
  )

  ;; A character is executed while being shielded.
  (:action execute-shielded
    :parameters
      (?character - character ?protector - character ?location - object)
    :precondition
      (and (alive ?character)
      (alive ?protector)
      (at ?character ?location)
      (at ?protector ?location)
      (not (loyal-to-rebellion ?character))
      (not (has-cloak ?character))
      (protects ?protector ?character ?location)
      (has-shield ?character))
    :effect
      (and (not (alive ?character))
      (executed ?character)
      (not (protects ?protector ?character ?location))
      (not (has-shield ?character)))
    :agents
      (?character ?protector)
  )
)