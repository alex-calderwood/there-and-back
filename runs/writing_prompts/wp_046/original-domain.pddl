(define (domain friendship)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object food - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (speaks-same-language ?character1 - character ?character2 - character)
    (has-name ?character - character)
    (eats ?character - character ?food - food)
    (comfortable ?character - character)
    (safe-and-secure ?character - character)
    (trusts ?character1 - character ?character2 - character)
    (has-balls ?character - character)
    (scratches-ears ?character1 - character ?character2 - character)
  )

  ;; A character moves from one place to another.
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

  ;; A character eats food.
  (:action eat
    :parameters
      (?character - character ?food - food)
    :precondition
      (and (alive ?character)
      (eats ?character ?food))
    :effect
      (comfortable ?character)
    :agents
      (?character)
  )

  ;; A character scratches another character's ears.
  (:action scratch-ears
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (= ?character1 ?character2)))
    :effect
      (scratches-ears ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character loses trust in another character.
  (:action lose-trust
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (trusts ?character1 ?character2))
    :effect
      (not (trusts ?character1 ?character2))
    :agents
      (?character1)
  )

  ;; A character loses their balls.
  (:action lose-balls
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has-balls ?character))
    :effect
      (not (has-balls ?character))
    :agents
      (?character)
  )
)