(define (domain killer-chase)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object weapon - item)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (trapped ?character - character ?place - place)
    (injured ?character - character)
    (tied ?character - character)
    (vigilant ?character - character)
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

  ;; A character sets a trap at a place.
  (:action set-trap
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place))
    :effect
      (trapped ?character ?place)
    :agents
      (?character)
  )

  ;; A character gets trapped.
  (:action get-trapped
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (trapped ?character ?place))
    :effect
      (injured ?character)
    :agents
      (?character)
  )

  ;; A character ties up another character.
  (:action tie-up
    :parameters
      (?character - character ?victim - character)
    :precondition
      (and (not (= ?character ?victim))
      (alive ?character)
      (alive ?victim)
      (injured ?victim))
    :effect
      (tied ?victim)
    :agents
      (?character)
  )

  ;; A character kills another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character ?weapon - weapon)
    :precondition
      (and (alive ?killer)
      (has ?killer ?weapon)
      (alive ?victim)
      (tied ?victim))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )

  ;; A character becomes vigilant.
  (:action become-vigilant
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (vigilant ?character)
    :agents
      (?character)
  )
)