(define (domain foggy-adventure)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (foggy ?place - place)
    (found ?item - item)
    (happy ?character - character)
    (friends ?character1 - character ?character2 - character)
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

  ;; A character searches for an item.
  (:action search
    :parameters
      (?character - character ?item - item ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (found ?item)))
    :effect
      (when (not (foggy ?place))
      (and (found ?item)
      (has ?character ?item)))
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; The fog clears at a place.
  (:action clear-fog
    :parameters
      (?place - place)
    :precondition
      (foggy ?place)
    :effect
      (not (foggy ?place))
  )
)