(define (domain vasily-and-the-wolves)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object weapon - item)
  (:constants
    vasily - character
    rifle - weapon
    ak-47 - weapon
    knife - weapon
    .45 - weapon)
  (:predicates
    (alive ?character - character)
    (armed ?character - character ?weapon - weapon)
    (has ?character - character ?item - item)
    (at ?character - character ?place - place)
    (dead ?animal - animal)
    (surrounding ?animal - animal ?character - character)
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

  ;; A character fires a weapon at an animal.
  (:action fire
    :parameters
      (?character - character ?weapon - weapon ?animal - animal)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?weapon)
      (surrounding ?animal ?character))
    :effect
      (and (not (surrounding ?animal ?character))
      (dead ?animal))
    :agents
      (?character)
  )

  ;; A character attacks an animal with a knife.
  (:action knife-attack
    :parameters
      (?character - character ?animal - animal)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character knife)
      (surrounding ?animal ?character))
    :effect
      (and (not (surrounding ?animal ?character))
      (dead ?animal))
    :agents
      (?character)
  )

  ;; A character reloads a weapon.
  (:action reload
    :parameters
      (?character - character ?weapon - weapon)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?weapon))
    :effect
      (and (not (has ?character ?weapon))
      (has ?character ?weapon))
    :agents
      (?character)
  )

  ;; A character drops a weapon.
  (:action drop
    :parameters
      (?character - character ?weapon - weapon)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?weapon))
    :effect
      (not (has ?character ?weapon))
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
  )

  ;; A character kills a group of animals.
  (:action kill-group
    :parameters
      (?character - character ?weapon - weapon ?animals - animal)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?weapon)
      (forall (?animal - animal)
      (surrounding ?animal ?character)))
    :effect
      (and (forall (?animal - animal)
      (not (surrounding ?animal ?character)))
      (forall (?animal - animal)
      (dead ?animal)))
    :agents
      (?character)
  )

  ;; A character is surrounded by a group of animals.
  (:axiom
    :vars
      (?character - character ?animal - animal)
    :context
      (and (at ?character ?place)
      (not (dead ?animal)))
    :implies
      (surrounding ?animal ?character)
  )
)