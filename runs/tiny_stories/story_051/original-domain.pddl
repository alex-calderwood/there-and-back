(define (domain magical-tree)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character animal - object place)
  (:predicates
    (at ?character - character ?place - place)
    (hugged ?hugger - character ?hugged - object)
    (door-open ?place - place)
    (friendly ?animal - animal)
  )

  ;; A character moves from one place to another.
  (:action move
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (door-open ?to))
    :effect
      (and (not (at ?character ?from))
      (at ?character ?to))
    :agents
      (?character)
  )

  ;; A character hugs an object.
  (:action hug
    :parameters
      (?hugger - character ?hugged - object)
    :precondition
      (at ?hugger (location ?hugged))
    :effect
      (hugged ?hugger ?hugged)
    :agents
      (?hugger)
  )

  ;; A character opens a door in a place.
  (:action open-door
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (not (door-open ?place)))
    :effect
      (door-open ?place)
    :agents
      (?character)
  )

  ;; A character closes a door in a place.
  (:action close-door
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (door-open ?place))
    :effect
      (not (door-open ?place))
    :agents
      (?character)
  )

  ;; When a character hugs an animal, the animal becomes friendly.
  (:axiom
    :vars
      (?character - character ?animal - animal)
    :context
      (and (not (friendly ?animal))
      (hugged ?character ?animal))
    :implies
      (friendly ?animal)
  )
)