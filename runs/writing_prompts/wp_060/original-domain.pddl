(define (domain anglewood-hunt)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?item - item)
    (clean ?item - item)
    (locked ?door - item)
    (wearing ?character - character ?item - item)
    (fits ?item - item ?character - character)
  )

  ;; A character cleans an item.
  (:action clean-item
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (not (clean ?item)))
    :effect
      (clean ?item)
    :agents
      (?character)
  )

  ;; A character locks a door.
  (:action lock-door
    :parameters
      (?character - character ?door - item)
    :precondition
      (and (alive ?character)
      (not (locked ?door)))
    :effect
      (locked ?door)
    :agents
      (?character)
  )

  ;; A character adjusts an item to fit them.
  (:action adjust-item
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (not (fits ?item ?character)))
    :effect
      (fits ?item ?character)
    :agents
      (?character)
  )

  ;; A character wears an item.
  (:action wear-item
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (fits ?item ?character)
      (not (wearing ?character ?item)))
    :effect
      (wearing ?character ?item)
    :agents
      (?character)
  )
)