(define (domain dealer-story)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (has-supply ?dealer - character)
    (high ?character - character)
    (businessman ?character - character)
    (charming ?character - character)
    (behind-closed-doors ?character - character)
    (intimate ?character1 - character ?character2 - character)
    (withdrawal ?character - character)
    (craving ?character - character)
  )

  ;; A character gets high from their own supply.
  (:action get-high
    :parameters
      (?dealer - character)
    :precondition
      (and (alive ?dealer)
      (has-supply ?dealer))
    :effect
      (high ?dealer)
    :agents
      (?dealer)
  )

  ;; A character becomes a businessman.
  (:action become-businessman
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (businessman ?character)
    :agents
      (?character)
  )

  ;; A character becomes charming.
  (:action become-charming
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (charming ?character)
    :agents
      (?character)
  )

  ;; A character goes behind closed doors with another character.
  (:action go-behind-closed-doors
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (= ?character1 ?character2)))
    :effect
      (and (behind-closed-doors ?character1)
      (behind-closed-doors ?character2))
    :agents
      (?character1 ?character2)
  )

  ;; Two characters become intimate.
  (:action become-intimate
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (= ?character1 ?character2))
      (behind-closed-doors ?character1)
      (behind-closed-doors ?character2))
    :effect
      (intimate ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character experiences withdrawal.
  (:action experience-withdrawal
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (intimate ?character ?other))
    :effect
      (withdrawal ?character)
    :agents
      (?character)
  )

  ;; A character craves more intimacy.
  (:action crave-more
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (withdrawal ?character))
    :effect
      (craving ?character)
    :agents
      (?character)
  )
)