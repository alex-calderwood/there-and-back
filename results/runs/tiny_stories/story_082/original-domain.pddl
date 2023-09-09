(define (domain tim-and-bird)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (awake ?character - character)
    (on-head ?bird - character ?character - character)
    (singing ?bird - character)
    (friends ?character1 - character ?character2 - character)
    (playing ?character1 - character ?character2 - character)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (at ?character ?place))
      (awake ?character))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character takes a nap.
  (:action nap
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (awake ?character)
      (at ?character ?place))
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

  ;; A bird lands on a character's head.
  (:action land-on-head
    :parameters
      (?bird - character ?character - character ?place - place)
    :precondition
      (and (not (on-head ?bird ?character))
      (at ?bird ?place)
      (at ?character ?place))
    :effect
      (on-head ?bird ?character)
    :agents
      (?bird)
  )

  ;; A bird sings a song.
  (:action sing
    :parameters
      (?bird - character)
    :precondition
      (not (singing ?bird))
    :effect
      (singing ?bird)
    :agents
      (?bird)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (friends ?character1 ?character2))
      (not (= ?character1 ?character2)))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; Two characters play together.
  (:action play-together
    :parameters
      (?character1 - character ?character2 - character ?place - place)
    :precondition
      (and (friends ?character1 ?character2)
      (at ?character1 ?place)
      (at ?character2 ?place))
    :effect
      (playing ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)