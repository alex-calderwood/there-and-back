(define (domain timmy-park-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (happy ?character - character)
    (powerful ?character - character)
    (playing ?character - character)
    (throwing ?character - character)
    (watching ?watcher - character ?watched - character)
    (hidden ?character - character)
    (gathered ?character - character)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - place)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character plays at a place.
  (:action play
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (playing ?character)
    :agents
      (?character)
  )

  ;; A character watches another character.
  (:action watch
    :parameters
      (?watcher - character ?watched - character)
    :precondition
      (and (not (= ?watcher ?watched))
      (not (watching ?watcher ?watched)))
    :effect
      (watching ?watcher ?watched)
    :agents
      (?watcher)
  )

  ;; A character throws a ball.
  (:action throw-ball
    :parameters
      (?character - character)
    :precondition
      (and (playing ?character)
      (not (throwing ?character)))
    :effect
      (throwing ?character)
    :agents
      (?character)
  )

  ;; A character hides.
  (:action hide
    :parameters
      (?character - character)
    :precondition
      (not (hidden ?character))
    :effect
      (hidden ?character)
    :agents
      (?character)
  )

  ;; A character gathers others.
  (:action gather
    :parameters
      (?gatherer - character ?gathered - character)
    :precondition
      (and (not (= ?gatherer ?gathered))
      (not (gathered ?gathered)))
    :effect
      (gathered ?gathered)
    :agents
      (?gatherer)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (not (happy ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes powerful.
  (:action become-powerful
    :parameters
      (?character - character)
    :precondition
      (not (powerful ?character))
    :effect
      (powerful ?character)
    :agents
      (?character)
  )
)