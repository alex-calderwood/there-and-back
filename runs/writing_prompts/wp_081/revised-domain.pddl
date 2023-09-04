(define (domain life-reflection)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object emotion - item)
  (:predicates
    (alive ?character - character)
    (has-emotion ?character - character ?emotion - emotion)
    (knows-change ?character - character)
    (memorize ?character - character)
  )

  ;; A character experiences an emotion.
  (:action experience-emotion
    :parameters
      (?character - character ?emotion - emotion)
    :precondition
      (alive ?character)
    :effect
      (has-emotion ?character ?emotion)
    :agents
      (?character)
  )

  ;; A character notices a change in their appearance.
  (:action notice-change
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (knows-change ?character)
    :agents
      (?character)
  )

  ;; A character memorizes their current appearance.
  (:action memorize-appearance
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (knows-change ?character))
    :effect
      (memorize ?character)
    :agents
      (?character)
  )
)