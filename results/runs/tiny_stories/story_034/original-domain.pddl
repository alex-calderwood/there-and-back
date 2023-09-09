(define (domain mask-friends)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (has ?character - character ?mask - object)
    (wearing ?character - character ?mask - object)
    (friends ?character1 - character ?character2 - character)
    (recognize ?character1 - character ?character2 - character)
  )

  ;; A character finds a mask.
  (:action find-mask
    :parameters
      (?character - character ?mask - object)
    :precondition
      (alive ?character)
    :effect
      (has ?character ?mask)
    :agents
      (?character)
  )

  ;; A character wears a mask.
  (:action wear-mask
    :parameters
      (?character - character ?mask - object)
    :precondition
      (and (alive ?character)
      (has ?character ?mask)
      (not (wearing ?character ?mask)))
    :effect
      (wearing ?character ?mask)
    :agents
      (?character)
  )

  ;; A character removes a mask.
  (:action remove-mask
    :parameters
      (?character - character ?mask - object)
    :precondition
      (and (alive ?character)
      (wearing ?character ?mask))
    :effect
      (not (wearing ?character ?mask))
    :agents
      (?character)
  )

  ;; A character recognizes another character.
  (:action recognize
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (friends ?character1 ?character2)
      (not (recognize ?character1 ?character2)))
    :effect
      (recognize ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; When a character is not wearing a mask, they are recognized by their friends.
  (:axiom
    :vars
      (?character1 - character ?character2 - character)
    :context
      (and (friends ?character1 ?character2)
      (not (exists (?mask - object)
      (wearing ?character2 ?mask))))
    :implies
      (recognize ?character1 ?character2)
  )
)