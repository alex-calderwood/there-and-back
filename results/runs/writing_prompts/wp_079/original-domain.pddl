(define (domain richard-rahl)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (happy ?character - character)
    (ruler ?character - character ?place - place)
    (supporter ?supporter - character ?ruler - character)
    (riots ?place - place)
    (discontent ?place - place)
    (united ?place - place)
  )

  ;; A character travels from one place to another.
  (:action travel
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

  ;; A character becomes a ruler of a place.
  (:action become-ruler
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (ruler ?character ?place)
    :agents
      (?character)
  )

  ;; A character supports another character.
  (:action support
    :parameters
      (?supporter - character ?ruler - character)
    :precondition
      (and (not (= ?supporter ?ruler))
      (ruler ?ruler ?place))
    :effect
      (supporter ?supporter ?ruler)
    :agents
      (?supporter)
  )

  ;; A character unites a place.
  (:action unite
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (ruler ?character ?place)
      (not (united ?place)))
    :effect
      (united ?place)
    :agents
      (?character)
  )

  ;; A character deals with riots or discontent.
  (:action deal-with-problems
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (ruler ?character ?place)
      (or (riots ?place)
      (discontent ?place)))
    :effect
      (and (not (riots ?place))
      (not (discontent ?place)))
    :agents
      (?character)
  )
)