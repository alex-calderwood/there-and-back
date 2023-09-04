(define (domain immortality)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants
    self - character)
  (:predicates
    (alive ?character - character)
    (immortal ?character - character)
    (judging ?character - character)
    (thirst ?character - character)
    (greed ?character - character)
    (pleasing ?character - character)
    (killing ?character - character)
    (approving ?character - character)
    (free ?character - character)
  )

  ;; A character communicates with another through looks and gestures.
  (:action communicate
    :parameters
      (?speaker - character ?listener - character)
    :precondition
      (and (alive ?speaker)
      (alive ?listener))
    :effect
      (and (not (judging ?speaker))
      (not (judging ?listener)))
    :agents
      (?speaker ?listener)
  )

  ;; A character becomes immortal.
  (:action become-immortal
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (immortal ?character)
    :agents
      (?character)
  )

  ;; A character develops an insatiable thirst.
  (:action develop-thirst
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (immortal ?character))
    :effect
      (thirst ?character)
    :agents
      (?character)
  )

  ;; A character becomes consumed by greed.
  (:action become-greedy
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (thirst ?character))
    :effect
      (greed ?character)
    :agents
      (?character)
  )

  ;; A character tries to please another.
  (:action try-to-please
    :parameters
      (?pleaser - character ?pleased - character)
    :precondition
      (and (alive ?pleaser)
      (alive ?pleased)
      (immortal ?pleaser)
      (greed ?pleased))
    :effect
      (pleasing ?pleaser)
    :agents
      (?pleaser)
  )

  ;; A character kills another.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim)
      (not (= ?killer ?victim))
      (or (not (immortal ?victim))
      (and (immortal ?killer)
      (not (immortal ?victim))))))
    :effect
      (and (not (alive ?victim))
      (killing ?killer))
    :agents
      (?killer)
  )

  ;; A character approves of another's actions.
  (:action approve
    :parameters
      (?approver - character ?approved - character)
    :precondition
      (and (alive ?approver)
      (alive ?approved)
      (pleasing ?approved))
    :effect
      (approving ?approver)
    :agents
      (?approver)
  )

  ;; A character becomes free.
  (:action become-free
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (immortal ?character))
      (not (greed ?character))
      (not (killing ?character)))
    :effect
      (free ?character)
    :agents
      (?character)
  )
)