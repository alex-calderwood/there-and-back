(define (domain smart-girl-dress)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object dress - item)
  (:predicates
    (wearing ?character - character ?dress - dress)
    (has ?character - character ?dress - dress)
    (damaged ?dress - dress)
    (happy ?character - character)
  )

  ;; A character puts on a dress.
  (:action put-on-dress
    :parameters
      (?character - character ?dress - dress)
    :precondition
      (and (has ?character ?dress)
      (not (wearing ?character ?dress)))
    :effect
      (wearing ?character ?dress)
    :agents
      (?character)
  )

  ;; A character slips and damages the dress they are wearing.
  (:action slip
    :parameters
      (?character - character ?dress - dress)
    :precondition
      (and (wearing ?character ?dress)
      (not (damaged ?dress)))
    :effect
      (damaged ?dress)
    :agents
      (?character)
  )

  ;; A character's parent comforts them.
  (:action comfort
    :parameters
      (?parent - character ?child - character)
    :precondition
      (not (happy ?child))
    :effect
      (happy ?child)
    :agents
      (?parent)
  )

  ;; A character gets a new dress.
  (:action get-new-dress
    :parameters
      (?character - character ?old-dress - dress ?new-dress - dress)
    :precondition
      (and (damaged ?old-dress)
      (wearing ?character ?old-dress)
      (not (has ?character ?new-dress)))
    :effect
      (and (not (wearing ?character ?old-dress))
      (has ?character ?new-dress))
    :agents
      (?character)
  )
)