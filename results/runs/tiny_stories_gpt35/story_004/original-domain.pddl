(define (domain chloe-garden)
  (:requirements :strips :typing :equality)
  (:types character - object)
  (:predicates
    (at ?character - character)
    (has-seen-tomato)
    (trusts ?character - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character sees a tomato.
  (:action see-tomato
    :parameters
      (?character - character)
    :precondition
      (at ?character garden)
    :effect
      (has-seen-tomato)
  )

  ;; A character trusts another character.
  (:action trust
    :parameters
      (?truster - character ?trusted - character)
    :precondition
      (and (not (= ?truster ?trusted))
      (at ?truster garden)
      (at ?trusted garden))
    :effect
      (trusts ?truster ?trusted)
  )
)