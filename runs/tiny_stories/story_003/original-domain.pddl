(define (domain flying-bike)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (broken-pedal ?bike - object)
    (fixed-pedal ?bike - object)
    (has ?character - character ?bike - object)
    (at-shop ?character - character)
    (happy ?character - character)
    (flying ?bike - object)
  )

  ;; A character goes to the shop.
  (:action go-to-shop
    :parameters
      (?character - character)
    :precondition
      (not (at-shop ?character))
    :effect
      (at-shop ?character)
    :agents
      (?character)
  )

  ;; A character fixes the pedal of a bike.
  (:action fix-pedal
    :parameters
      (?character - character ?bike - object)
    :precondition
      (and (at-shop ?character)
      (has ?character ?bike)
      (broken-pedal ?bike))
    :effect
      (and (not (broken-pedal ?bike))
      (fixed-pedal ?bike))
    :agents
      (?character)
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

  ;; A bike starts flying.
  (:action start-flying
    :parameters
      (?bike - object)
    :precondition
      (and (fixed-pedal ?bike)
      (not (flying ?bike)))
    :effect
      (flying ?bike)
  )
)