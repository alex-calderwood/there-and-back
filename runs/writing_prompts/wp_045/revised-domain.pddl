(define (domain cat-guardian)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object box - object)
  (:predicates
    (in-box ?character - character ?box - box)
    (at ?character - character ?place - place)
    (at ?box - box ?place - place)
    (nervous ?character - character)
    (composed ?character - character)
    (noticed ?character - character ?box - box)
    (opened ?box - box)
  )

  ;; A character enters a place.
  (:action enter
    :parameters
      (?character - character ?place - place)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character notices a box.
  (:action notice
    :parameters
      (?character - character ?box - box ?place - place)
    :precondition
      (and (at ?character ?place)
      (at ?box ?place))
    :effect
      (noticed ?character ?box)
    :agents
      (?character)
  )

  ;; A character opens a box.
  (:action open-box
    :parameters
      (?character - character ?box - box ?place - place)
    :precondition
      (and (at ?character ?place)
      (at ?box ?place)
      (noticed ?character ?box)
      (not (opened ?box)))
    :effect
      (opened ?box)
    :agents
      (?character)
  )

  ;; A character becomes nervous.
  (:action become-nervous
    :parameters
      (?character - character)
    :effect
      (nervous ?character)
    :agents
      (?character)
  )

  ;; A character becomes composed.
  (:action become-composed
    :parameters
      (?character - character)
    :effect
      (composed ?character)
    :agents
      (?character)
  )
)