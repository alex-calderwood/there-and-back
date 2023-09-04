(define (domain razor-balancing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?place - object)
    (can-balance ?character - character)
    (balanced ?character - character)
    (amazed ?character - character)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - object)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character balances on a razor.
  (:action balance
    :parameters
      (?character - character)
    :precondition
      (can-balance ?character)
    :effect
      (balanced ?character)
    :agents
      (?character)
  )

  ;; A character becomes amazed by another character.
  (:action become-amazed
    :parameters
      (?amazed - character ?amazing - character)
    :precondition
      (and (not (= ?amazed ?amazing))
      (not (amazed ?amazed))
      (balanced ?amazing))
    :effect
      (amazed ?amazed)
    :agents
      (?amazed)
  )
)