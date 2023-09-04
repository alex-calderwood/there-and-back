(define (domain moby-dick)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (knows-how-to-kill-whale ?character - character)
    (intends ?character - character ?predicate - predicate)
    (has-read-moby-dick ?character - character)
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

  ;; A character reads Moby Dick.
  (:action read-moby-dick
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (has-read-moby-dick ?character)
    :agents
      (?character)
  )

  ;; A character learns how to kill a whale.
  (:action learn-how-to-kill-whale
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has-read-moby-dick ?character))
    :effect
      (knows-how-to-kill-whale ?character)
    :agents
      (?character)
  )

  ;; A character kills a whale.
  (:action kill-whale
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (knows-how-to-kill-whale ?character))
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )
)