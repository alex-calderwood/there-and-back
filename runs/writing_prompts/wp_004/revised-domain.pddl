(define (domain earth-reentry)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character planet - object)
  (:predicates
    (on-planet ?character - character ?planet - planet)
    (in-formation ?character - character)
    (in-airlock ?character - character)
    (wingsuit-active ?character - character)
    (suit-pressurized ?character - character)
    (reached-altitude ?character - character)
    (reached-speed ?character - character)
  )

  ;; A character enters the airlock.
  (:action enter-airlock
    :parameters
      (?character - character)
    :precondition
      (not (in-airlock ?character))
    :effect
      (in-airlock ?character)
    :agents
      (?character)
  )

  ;; A character pressurizes their suit.
  (:action pressurize-suit
    :parameters
      (?character - character)
    :precondition
      (and (in-airlock ?character)
      (not (suit-pressurized ?character)))
    :effect
      (suit-pressurized ?character)
    :agents
      (?character)
  )

  ;; A character jumps from the ship.
  (:action jump
    :parameters
      (?character - character ?planet - planet)
    :precondition
      (and (suit-pressurized ?character)
      (not (on-planet ?character ?planet)))
    :effect
      (and (reached-altitude ?character)
      (reached-speed ?character))
    :agents
      (?character)
  )

  ;; A character activates their wingsuit.
  (:action activate-wingsuit
    :parameters
      (?character - character)
    :precondition
      (and (reached-altitude ?character)
      (reached-speed ?character)
      (not (wingsuit-active ?character)))
    :effect
      (wingsuit-active ?character)
    :agents
      (?character)
  )

  ;; A character lands on the planet.
  (:action land
    :parameters
      (?character - character ?planet - planet)
    :precondition
      (and (wingsuit-active ?character)
      (not (on-planet ?character ?planet)))
    :effect
      (on-planet ?character ?planet)
    :agents
      (?character)
  )
)