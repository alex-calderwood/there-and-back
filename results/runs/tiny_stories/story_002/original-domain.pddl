(define (domain bird-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types bird place - object)
  (:predicates
    (on-ground ?bird - bird)
    (in-sky ?bird - bird)
    (at ?bird - bird ?place - place)
    (friends ?bird1 - bird ?bird2 - bird)
    (happy ?bird - bird)
  )

  ;; A bird starts flying.
  (:action start-flying
    :parameters
      (?bird - bird)
    :precondition
      (and (on-ground ?bird))
    :effect
      (and (not (on-ground ?bird))
      (in-sky ?bird))
    :agents
      (?bird)
  )

  ;; A bird stops flying.
  (:action stop-flying
    :parameters
      (?bird - bird)
    :precondition
      (and (in-sky ?bird))
    :effect
      (and (not (in-sky ?bird))
      (on-ground ?bird))
    :agents
      (?bird)
  )

  ;; A bird moves to a new place.
  (:action move
    :parameters
      (?bird - bird ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?bird ?from))
    :effect
      (and (not (at ?bird ?from))
      (at ?bird ?to))
    :agents
      (?bird)
  )

  ;; Two birds become friends.
  (:action make-friends
    :parameters
      (?bird1 - bird ?bird2 - bird)
    :precondition
      (and (not (= ?bird1 ?bird2))
      (not (friends ?bird1 ?bird2)))
    :effect
      (friends ?bird1 ?bird2)
    :agents
      (?bird1 ?bird2)
  )

  ;; A bird becomes happy.
  (:action become-happy
    :parameters
      (?bird - bird)
    :precondition
      (not (happy ?bird))
    :effect
      (happy ?bird)
    :agents
      (?bird)
  )
)