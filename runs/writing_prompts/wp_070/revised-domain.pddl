(define (domain ice-cream-discussion)
  (:requirements :adl :domain-axioms :intentionality :expression-variables)
  (:types character - object flavor - item)
  (:predicates
    (discussing ?character - character ?topic - expression)
    (favorite-flavor ?character - character ?flavor - flavor)
    (inspired-by ?series - expression ?prompt - expression)
  )

  ;; A character discusses a topic.
  (:action discuss
    :parameters
      (?character - character ?topic - expression)
    :precondition
      (alive ?character)
    :effect
      (discussing ?character ?topic)
    :agents
      (?character)
  )

  ;; A character reveals their favorite ice cream flavor.
  (:action reveal-favorite-flavor
    :parameters
      (?character - character ?flavor - flavor)
    :precondition
      (alive ?character)
    :effect
      (favorite-flavor ?character ?flavor)
    :agents
      (?character)
  )

  ;; A character suggests a change in rules or tags.
  (:action suggest-change
    :parameters
      (?character - character ?rule - expression ?change - expression)
    :precondition
      (alive ?character)
    :effect
      (and (discussing ?character ?rule)
      (discussing ?character ?change))
    :agents
      (?character)
  )
)