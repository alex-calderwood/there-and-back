(define (domain mop-shopping)
  (:requirements :strips :typing :equality)
  (:types mop - object handle - object color - object girl mom dog - character)
  (:constants pink blue clean-pretty-mop - mop)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - object)
    (likes ?girl - girl ?mop - mop)
    (chooses ?mom - mom ?mop - mop)
    (found ?mop - mop)
    (clean ?mop - mop)
    (pretty ?mop - mop)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A girl likes a mop.
  (:action like
    :parameters
      (?girl - girl ?mop - mop)
    :precondition
      (and (at ?girl store)
      (at ?mop store))
    :effect
      (likes ?girl ?mop)
    :agents
      (?girl)
  )

  ;; A mom chooses a mop.
  (:action choose
    :parameters
      (?mom - mom ?mop - mop)
    :precondition
      (and (at ?mom store)
      (at ?mop store)
      (likes ?mom ?mop))
    :effect
      (chooses ?mom ?mop)
    :agents
      (?mom)
  )

  ;; A dog finds a mop.
  (:action find
    :parameters
      (?dog - dog ?mop - mop)
    :precondition
      (and (at ?dog store)
      (at ?mop store)
      (not (has ?dog ?mop)))
    :effect
      (and (has ?dog ?mop)
      (found ?mop))
    :agents
      (?dog)
  )

  ;; A mop becomes clean and pretty.
  (:action clean-pretty
    :parameters
      (?mop - mop)
    :precondition
      (and (found ?mop))
    :effect
      (and (clean ?mop)
      (pretty ?mop))
  )

  ;; A character takes an item from another.
  (:action take
    :parameters
      (?taker - character ?item - object ?giver - character ?place - place)
    :precondition
      (and (not (= ?taker ?giver))
      (at ?taker ?place)
      (at ?giver ?place)
      (has ?giver ?item))
    :effect
      (and (not (has ?giver ?item))
      (has ?taker ?item))
    :agents
      (?taker)
  )
)