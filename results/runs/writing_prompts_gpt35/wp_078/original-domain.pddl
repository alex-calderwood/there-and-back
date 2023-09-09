(define (domain kingdom-feast)
  (:requirements :adl :domain-axioms)
  (:types character - object noble - character)
  (:predicates
    (married ?character - character)
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (kidnapped ?noble - noble)
    (trap-door ?place - place)
    (in-love ?character - character ?noble - noble)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
  )

  ;; A character picks up an item.
  (:action pickup
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?place ?item))
    :effect
      (and (not (has ?place ?item))
      (has ?character ?item))
  )

  ;; A character puts down an item.
  (:action putdown
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (has ?place ?item))
  )

  ;; A character kidnaps a noble.
  (:action kidnap
    :parameters
      (?character - character ?noble - noble ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (at ?noble ?place)
      (in-love ?character ?noble))
    :effect
      (and (not (at ?noble ?place))
      (kidnapped ?noble))
  )

  ;; A character confronts another character.
  (:action confront
    :parameters
      (?confronter - character ?confrontee - character ?place - place)
    :precondition
      (and (alive ?confronter)
      (at ?confronter ?place)
      (alive ?confrontee)
      (at ?confrontee ?place))
    :effect
      (and (not (alive ?confrontee))
      (not (in-love ?confronter ?confrontee)))
  )

  ;; A character activates a trap door.
  (:action activate-trap
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (trap-door ?place))
    :effect
      (not (trap-door ?place))
  )
)