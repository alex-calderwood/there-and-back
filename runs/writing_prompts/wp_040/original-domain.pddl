(define (domain winter-king)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has-power ?character - character ?power - power)
    (brothers ?character1 - character ?character2 - character)
    (tyrant ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
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

  ;; A character confronts another.
  (:action confront
    :parameters
      (?confronter - character ?confronted - character ?place - place)
    :precondition
      (and (not (= ?confronter ?confronted))
      (alive ?confronter)
      (at ?confronter ?place)
      (alive ?confronted)
      (at ?confronted ?place))
    :effect
      (and)
    :agents
      (?confronter)
  )

  ;; A character defeats another.
  (:action defeat
    :parameters
      (?defeater - character ?defeated - character ?place - place)
    :precondition
      (and (not (= ?defeater ?defeated))
      (alive ?defeater)
      (at ?defeater ?place)
      (alive ?defeated)
      (at ?defeated ?place))
    :effect
      (not (alive ?defeated))
    :agents
      (?defeater)
  )

  ;; A character shows mercy to another.
  (:action show-mercy
    :parameters
      (?merciful - character ?recipient - character ?place - place)
    :precondition
      (and (not (= ?merciful ?recipient))
      (alive ?merciful)
      (at ?merciful ?place)
      (not (alive ?recipient))
      (at ?recipient ?place))
    :effect
      (alive ?recipient)
    :agents
      (?merciful)
  )
)