(define (domain spot-and-the-perfume)
  (:requirements :strips :typing)
  (:types dog - object perfume - item)
  (:predicates
    (on-table ?item - item)
    (smells-nice ?item - item)
    (has ?dog - dog ?item - item)
  )

  ;; A dog jumps on the table to get an item.
  (:action jump-on-table
    :parameters
      (?dog - dog ?item - item)
    :precondition
      (and (not (has ?dog ?item))
      (on-table ?item))
    :effect
      (has ?dog ?item)
    :agents
      (?dog)
  )

  ;; A dog smells like an item.
  (:action smell-like
    :parameters
      (?dog - dog ?item - item)
    :precondition
      (and (has ?dog ?item)
      (smells-nice ?item))
    :effect
      (smells-nice ?dog)
    :agents
      (?dog)
  )
)