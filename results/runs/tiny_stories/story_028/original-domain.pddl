(define (domain lily-and-soap)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (on-shelf ?item - item)
    (organized ?place - place)
    (reads ?character - character)
    (happy ?character - character)
  )

  ;; A character finds an item.
  (:action find
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (not (has ?character ?item))
      (reads ?character))
    :effect
      (has ?character ?item)
    :agents
      (?character)
  )

  ;; A character puts an item on the shelf.
  (:action put-on-shelf
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (has ?character ?item)
      (at ?character ?place))
    :effect
      (and (not (has ?character ?item))
      (on-shelf ?item)
      (organized ?place))
    :agents
      (?character)
  )

  ;; A character reads a book.
  (:action read
    :parameters
      (?character - character)
    :precondition
      (reads ?character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character smells the soap.
  (:action smell-soap
    :parameters
      (?character - character ?soap - item)
    :precondition
      (and (on-shelf ?soap)
      (reads ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )
)