(define (domain tim-and-ben)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character toy - object)
  (:predicates
    (in-drawer ?toy - toy)
    (friends ?character1 - character ?character2 - character)
    (friends ?character - character ?toy - toy)
    (wants-to-take ?character - character ?toy - toy)
    (brave ?character - character)
  )

  ;; A character finds a toy in a drawer.
  (:action find-toy
    :parameters
      (?character - character ?toy - toy)
    :precondition
      (in-drawer ?toy)
    :effect
      (and (not (in-drawer ?toy))
      (friends ?character ?toy))
    :agents
      (?character)
  )

  ;; A character wants to take a toy from another character.
  (:action want-to-take
    :parameters
      (?taker - character ?toy - toy ?owner - character)
    :precondition
      (and (not (= ?taker ?owner))
      (friends ?owner ?toy))
    :effect
      (wants-to-take ?taker ?toy)
    :agents
      (?taker)
  )

  ;; A character stands up to another character.
  (:action stand-up
    :parameters
      (?defender - character ?taker - character ?toy - toy)
    :precondition
      (and (not (= ?defender ?taker))
      (wants-to-take ?taker ?toy)
      (friends ?defender ?toy))
    :effect
      (and (not (wants-to-take ?taker ?toy))
      (brave ?defender))
    :agents
      (?defender)
  )
)