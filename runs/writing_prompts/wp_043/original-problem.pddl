(define (problem mcdonalds-mars)
  (:domain
    mcdonalds-on-mars)
  (:objects
    nasa ceo alien - character
    earth mars - place)
  (:init
    (alive nasa)
    (at nasa mars)
    (intends nasa (discovered mars))
    (alive ceo)
    (at ceo earth)
    (is-ceo ceo)
    (intends ceo (knows-about ceo mars))
    (alive alien)
    (at alien earth)
    (is-alien alien)
    (intends alien (forall (?listener - character)
      (knows-about ?listener alien))))
  (:goal
    (and (discovered mars)
    (forall (?listener - character)
      (knows-about ?listener mars))
    (forall (?listener - character)
      (knows-about ?listener alien)))
  )
)