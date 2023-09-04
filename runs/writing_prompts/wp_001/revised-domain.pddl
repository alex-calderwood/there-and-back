(define (domain post-apocalyptic-world)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object weapon - item)
  (:constants tv - item)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (on ?item - item)
    (broadcasting ?item - item)
    (generator-active ?place - place)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character turns on an item.
  (:action turn-on
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (not (on ?item)))
    :effect
      (on ?item)
    :agents  (?character)
  )

  ;; A character turns off an item.
  (:action turn-off
    :parameters
      (?character - character ?item - item)
    :precondition
      (and (alive ?character)
      (has ?character ?item)
      (on ?item))
    :effect
      (not (on ?item))
    :agents  (?character)
  )

  ;; A character starts a generator.
  (:action start-generator
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (not (generator-active ?place)))
    :effect
      (generator-active ?place)
    :agents  (?character)
  )

  ;; A character stops a generator.
  (:action stop-generator
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (alive ?character)
      (at ?character ?place)
      (generator-active ?place))
    :effect
      (not (generator-active ?place))
    :agents  (?character)
  )

  ;; When a generator is active, the TV broadcasts.
  (:axiom
    :vars
      (?place - place)
    :context
      (and (not (broadcasting tv))
      (generator-active ?place))
    :implies
      (broadcasting tv)
  )

  ;; When a generator is inactive, the TV stops broadcasting.
  (:axiom
    :vars
      (?place - place)
    :context
      (and (broadcasting tv)
      (not (generator-active ?place)))
    :implies
      (not (broadcasting tv))
  )
)