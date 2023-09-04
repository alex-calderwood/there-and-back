(define (domain ball-mailbox)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (in-mailbox ?item - item)
    (happy ?character - character)
    (sad ?character - character)
    (small ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character picks up an item.
  (:action pick-up
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (in-mailbox ?item))
      (not (has ?character ?item)))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character throws an item into the mailbox.
  (:action throw-in-mailbox
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (has ?character ?item)
      (not (in-mailbox ?item)))
    :effect
      (and (not (has ?character ?item))
      (in-mailbox ?item))
    :agents
      (?character)
  )

  ;; A small character retrieves an item from the mailbox.
  (:action retrieve-from-mailbox
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (small ?character)
      (in-mailbox ?item)
      (not (has ?character ?item)))
    :effect
      (and (not (in-mailbox ?item))
      (has ?character ?item))
    :agents
      (?character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (sad ?character)
    :effect
      (and (not (sad ?character))
      (happy ?character))
    :agents
      (?character)
  )

  ;; A character becomes sad.
  (:action become-sad
    :parameters
      (?character - character)
    :precondition
      (happy ?character)
    :effect
      (and (not (happy ?character))
      (sad ?character))
    :agents
      (?character)
  )
)