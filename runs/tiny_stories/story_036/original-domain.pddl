(define (domain fairy-and-pins)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object box - item pin - item)
  (:predicates
    (in ?pin - pin ?box - box)
    (tidy ?box - box)
    (on-floor ?pin - pin)
    (scared ?pin - pin)
    (alive ?pin - pin)
    (at ?character - character ?box - box)
    (fairy ?character - character)
  )

  ;; A character picks up a pin from the floor and puts it in the box.
  (:action pick-up-pin
    :parameters
      (?character - character ?pin - pin ?box - box)
    :precondition
      (and (at ?character ?box)
      (on-floor ?pin)
      (tidy ?box))
    :effect
      (and (not (on-floor ?pin))
      (in ?pin ?box)
      (not (scared ?pin)))
    :agents  (?character)
  )

  ;; A character opens the box and the pins fall on the floor.
  (:action open-box
    :parameters
      (?character - character ?box - box)
    :precondition
      (and (at ?character ?box)
      (tidy ?box))
    :effect
      (forall (?pin - pin)
        (and (not (in ?pin ?box))
        (on-floor ?pin)
        (scared ?pin)))
    :agents  (?character)
  )

  ;; A fairy character brings a pin to life.
  (:action bring-to-life
    :parameters
      (?fairy - character ?pin - pin)
    :precondition
      (and (fairy ?fairy)
      (in ?pin ?box))
    :effect
      (alive ?pin)
    :agents  (?fairy)
  )

  ;; A fairy character becomes friends with a pin.
  (:action become-friends
    :parameters
      (?fairy - character ?pin - pin)
    :precondition
      (and (fairy ?fairy)
      (alive ?pin))
    :effect
      (intends ?fairy (alive ?pin))
    :agents  (?fairy)
  )
)