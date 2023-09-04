(define (domain cat-dog-park)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character seat - object)
  (:predicates
    (at ?character - character ?place - place)
    (sitting ?character - character ?seat - seat)
    (broken ?seat - seat)
    (big ?seat - seat)
    (small ?seat - seat)
    (important ?character - character)
  )

  ;; A character moves to a place.
  (:action move
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (not (at ?character ?place)))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character sits on a seat.
  (:action sit
    :parameters
      (?character - character ?seat - seat)
    :precondition
      (and (not (sitting ?character ?seat))
      (not (broken ?seat)))
    :effect
      (sitting ?character ?seat)
    :agents
      (?character)
  )

  ;; A character leaves a seat.
  (:action leave
    :parameters
      (?character - character ?seat - seat)
    :precondition
      (sitting ?character ?seat)
    :effect
      (not (sitting ?character ?seat))
    :agents
      (?character)
  )

  ;; A seat breaks.
  (:action break-seat
    :parameters
      (?seat - seat)
    :precondition
      (not (broken ?seat))
    :effect
      (broken ?seat)
  )

  ;; A character becomes important.
  (:action become-important
    :parameters
      (?character - character)
    :precondition
      (not (important ?character))
    :effect
      (important ?character)
    :agents
      (?character)
  )

  ;; A character becomes unimportant.
  (:action become-unimportant
    :parameters
      (?character - character)
    :precondition
      (important ?character)
    :effect
      (not (important ?character))
    :agents
      (?character)
  )
)