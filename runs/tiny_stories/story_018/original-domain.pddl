(define (domain daisy-treasure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (found ?character - character ?item - item)
    (hidden ?item - item ?place - place)
    (open ?item - item)
    (stored ?item - item ?place - place)
  )

  ;; A character searches a place.
  (:action search
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (forall (?item - item)
        (when (hidden ?item ?place)
          (found ?character ?item)))
    :agents
      (?character)
  )

  ;; A character opens an item.
  (:action open
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (found ?character ?item)
           (not (open ?item)))
    :effect
      (open ?item)
    :agents
      (?character)
  )

  ;; A character stores an item in a place.
  (:action store
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (found ?character ?item)
           (open ?item)
           (at ?character ?place))
    :effect
      (stored ?item ?place)
    :agents
      (?character)
  )
)