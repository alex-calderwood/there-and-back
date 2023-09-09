(define (domain mcdonalds-on-mars)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (discovered ?place - place)
    (knows-about ?character - character ?place - place)
    (is-ceo ?character - character)
    (is-alien ?character - character)
  )

  ;; A character discovers a place.
  (:action discover
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (discovered ?place)))
    :effect
      (discovered ?place)
    :agents  (?character)
  )

  ;; A character learns about a place.
  (:action learn
    :parameters
      (?learner - character ?place - place)
    :precondition
      (and (alive ?learner)
      (discovered ?place))
    :effect
      (knows-about ?learner ?place)
    :agents  (?learner)
  )

  ;; A character holds a press conference.
  (:action hold-press-conference
    :parameters
      (?speaker - character ?place - place)
    :precondition
      (and (alive ?speaker)
      (is-ceo ?speaker)
      (knows-about ?speaker ?place))
    :effect
      (forall (?listener - character)
        (knows-about ?listener ?place))
    :agents  (?speaker)
  )

  ;; An alien character reveals themselves.
  (:action reveal
    :parameters
      (?alien - character)
    :precondition
      (and (alive ?alien)
      (is-alien ?alien))
    :effect
      (forall (?listener - character)
        (knows-about ?listener ?alien))
    :agents  (?alien)
  )
)