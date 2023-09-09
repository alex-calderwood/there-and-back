(define (domain vasily-wolf-hunter)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object weapon - item)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (wolves-attack ?place - place)
    (wolves-killed ?character - character)
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

  ;; A character kills wolves.
  (:action kill-wolves
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (wolves-attack ?place))
    :effect
      (wolves-killed ?character)
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