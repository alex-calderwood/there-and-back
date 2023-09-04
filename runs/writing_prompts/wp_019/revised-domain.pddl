(define (domain time-traveler)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object item - item)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (buried ?item - item ?place - place)
    (destroyed ?item - item)
    (explosives-set ?place - place)
  )

  ;; A character travels from one place to another.
  (:action travel
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

  ;; A character sets explosives at a place.
  (:action set-explosives
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (explosives-set ?place)
    :agents
      (?character)
  )

  ;; A character detonates explosives at a place.
  (:action detonate-explosives
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (explosives-set ?place))
    :effect
      (forall (?item - item)
        (when (buried ?item ?place)
          (destroyed ?item)))
    :agents
      (?character)
  )

  ;; A character destroys an item.
  (:action destroy-item
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item))
    :effect
      (and (not (has ?character ?item))
      (destroyed ?item))
    :agents
      (?character)
  )
)