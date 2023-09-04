(define (domain forest-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (stuck ?character - character ?place - place)
    (helped ?helper - character ?helpee - character)
    (friends ?character1 - character ?character2 - character)
  )

  ;; A character moves to a new place.
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

  ;; A character gets stuck in a place.
  (:action get-stuck
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (stuck ?character ?place)))
    :effect
      (stuck ?character ?place)
    :agents
      (?character)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character ?place - place)
    :precondition
      (and (not (= ?helper ?helpee))
      (at ?helper ?place)
      (stuck ?helpee ?place))
    :effect
      (and (not (stuck ?helpee ?place))
      (helped ?helper ?helpee))
    :agents
      (?helper)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (friends ?character1 ?character2))
      (helped ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)