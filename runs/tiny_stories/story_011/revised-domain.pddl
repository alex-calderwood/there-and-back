(define (domain garden-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (awake ?character - character)
    (friends ?character1 - character ?character2 - character)
    (interesting ?place - place)
    (singing ?character - character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (awake ?character)
      (not (at ?character ?place)))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character sleeps.
  (:action sleep
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (awake ?character)
      (at ?character ?place)
      (interesting ?place))
    :effect
      (not (awake ?character))
    :agents
      (?character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (not (awake ?character))
    :effect
      (awake ?character)
    :agents
      (?character)
  )

  ;; A character sings.
  (:action sing
    :parameters
      (?character - character)
    :precondition
      (awake ?character)
    :effect
      (singing ?character)
    :agents
      (?character)
  )

  ;; A character stops singing.
  (:action stop-singing
    :parameters
      (?character - character)
    :precondition
      (singing ?character)
    :effect
      (not (singing ?character))
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action make-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (awake ?character1)
      (awake ?character2)
      (not (friends ?character1 ?character2))
      (not (= ?character1 ?character2)))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)