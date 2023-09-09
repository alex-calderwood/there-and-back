(define (domain magical-bird)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object bird - creature)
  (:predicates
    (at ?character - character ?place - object)
    (alive ?character - character)
    (injured ?bird - bird)
    (has ?character - character ?bird - bird)
    (inside ?character - character ?place - object)
    (locked ?place - object)
    (broken-lock ?place - object)
    (tracks ?character - character ?place - object)
    (blood-trail ?character - character ?place - object)
  )

  ;; A character discovers tracks and blood trail.
  (:action discover-tracks
    :parameters
      (?character - character ?place - object)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (tracks ?character ?place)
      (blood-trail ?character ?place))
    :effect
      (and (intends ?character (inside ?character ?place)))
    :agents
      (?character)
  )

  ;; A character enters a place.
  (:action enter
    :parameters
      (?character - character ?place - object)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (inside ?character ?place))
      (not (locked ?place)))
    :effect
      (inside ?character ?place)
    :agents
      (?character)
  )

  ;; A character finds an injured bird.
  (:action find-injured-bird
    :parameters
      (?character - character ?bird - bird ?place - object)
    :precondition
      (and (alive ?character)
      (inside ?character ?place)
      (injured ?bird)
      (inside ?bird ?place))
    :effect
      (and (has ?character ?bird)
      (intends ?character (heal ?bird)))
    :agents
      (?character)
  )

  ;; A character heals a bird.
  (:action heal
    :parameters
      (?character - character ?bird - bird)
    :precondition
      (and (alive ?character)
      (has ?character ?bird)
      (injured ?bird))
    :effect
      (not (injured ?bird))
    :agents
      (?character)
  )

  ;; A character breaks a lock.
  (:action break-lock
    :parameters
      (?character - character ?place - object)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (locked ?place))
    :effect
      (and (not (locked ?place))
      (broken-lock ?place))
    :agents
      (?character)
  )
)