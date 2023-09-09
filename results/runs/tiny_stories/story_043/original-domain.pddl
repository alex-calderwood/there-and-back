(define (domain remy-and-friends)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (safe ?character - character)
    (hungry ?character - character)
    (chasing ?chaser - character ?target - character)
    (has-long-tail ?character - character)
    (in-hole ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character starts chasing another character.
  (:action start-chasing
    :parameters
      (?chaser - character ?target - character)
    :precondition
      (and (not (= ?chaser ?target))
      (hungry ?chaser))
    :effect
      (chasing ?chaser ?target)
    :agents
      (?chaser)
  )

  ;; A character hides in a hole.
  (:action hide-in-hole
    :parameters
      (?character - character ?hole - place)
    :precondition
      (at ?character ?hole)
    :effect
      (and (in-hole ?character)
      (safe ?character))
    :agents
      (?character)
  )

  ;; A character stops chasing another character.
  (:action stop-chasing
    :parameters
      (?chaser - character ?target - character)
    :precondition
      (chasing ?chaser ?target)
    :effect
      (not (chasing ?chaser ?target))
    :agents
      (?chaser)
  )

  ;; When a character has a long tail, they can run faster.
  (:axiom
    :vars
      (?character - character)
    :context
      (has-long-tail ?character)
    :implies
      (safe ?character)
  )
)