(define (domain magic-bird)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at ?character - character ?place - object)
    (has ?character - character ?item - object)
    (happy ?character - character)
    (magic ?character - character)
    (granted-wish ?wish - object)
  )

  ;; A character goes to a place.
  (:action go-to
    :parameters
      (?character - character ?place - object)
    :precondition
      (not (at ?character ?place))
    :effect
      (at ?character ?place)
    :agents
      (?character)
  )

  ;; A character sits down.
  (:action sit-down
    :parameters
      (?character - character)
    :precondition
      (not (happy ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character shares a snack with another character.
  (:action share-snack
    :parameters
      (?sharer - character ?receiver - character ?snack - object)
    :precondition
      (and (has ?sharer ?snack)
      (not (has ?receiver ?snack)))
    :effect
      (has ?receiver ?snack)
    :agents
      (?sharer)
  )

  ;; A character becomes magic.
  (:action become-magic
    :parameters
      (?character - character)
    :precondition
      (not (magic ?character))
    :effect
      (magic ?character)
    :agents
      (?character)
  )

  ;; A character grants a wish.
  (:action grant-wish
    :parameters
      (?granter - character ?wish - object)
    :precondition
      (magic ?granter)
    :effect
      (granted-wish ?wish)
    :agents
      (?granter)
  )
)