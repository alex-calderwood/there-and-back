(define (domain human-chop-shop)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object key - item)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (locked ?door - place)
    (unlocked ?door - place)
    (matches ?key - key ?door - place)
    (knows-location ?character - character ?place - place)
    (alive ?character - character)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character steals an item from another character.
  (:action steal
    :parameters
      (?thief - character ?item - item ?victim - character)
    :precondition
      (and (not (= ?thief ?victim))
      (alive ?thief)
      (alive ?victim)
      (has ?victim ?item))
    :effect
      (and (not (has ?victim ?item))
      (has ?thief ?item))
    :agents
      (?thief)
  )

  ;; A character unlocks a door with a key.
  (:action unlock
    :parameters
      (?character - character ?key - key ?door - place)
    :precondition
      (and (alive ?character)
      (has ?character ?key)
      (matches ?key ?door)
      (locked ?door))
    :effect
      (and (not (locked ?door))
      (unlocked ?door))
    :agents
      (?character)
  )

  ;; A character locks a door with a key.
  (:action lock
    :parameters
      (?character - character ?key - key ?door - place)
    :precondition
      (and (alive ?character)
      (has ?character ?key)
      (matches ?key ?door)
      (unlocked ?door))
    :effect
      (and (not (unlocked ?door))
      (locked ?door))
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (alive ?character))
    :agents
      (?character)
  )
)