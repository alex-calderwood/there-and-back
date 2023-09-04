(define (domain hide-and-seek)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object)
  (:predicates
    (at ?character - character ?place - place)
    (hiding ?character - character)
    (seeking ?character - character)
    (found ?seeker - character ?hider - character)
  )

  ;; A character starts hiding.
  (:action start-hiding
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (hiding ?character)
    :agents
      (?character)
  )

  ;; A character starts seeking.
  (:action start-seeking
    :parameters
      (?character - character ?place - place)
    :precondition
      (at ?character ?place)
    :effect
      (seeking ?character)
    :agents
      (?character)
  )

  ;; A character finds another character hiding.
  (:action find
    :parameters
      (?seeker - character ?hider - character ?place - place)
    :precondition
      (and (seeking ?seeker)
      (hiding ?hider)
      (at ?seeker ?place)
      (at ?hider ?place))
    :effect
      (and (found ?seeker ?hider)
      (not (hiding ?hider)))
    :agents
      (?seeker)
  )

  ;; A character stops seeking.
  (:action stop-seeking
    :parameters
      (?character - character)
    :precondition
      (seeking ?character)
    :effect
      (not (seeking ?character))
    :agents
      (?character)
  )
)