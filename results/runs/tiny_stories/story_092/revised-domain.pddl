(define (domain dan-university)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (worried ?character - character)
    (accepted-to-university ?character - character)
    (happy ?character - character)
    (applauding ?character - character)
    (hardworking ?character - character)
    (dreams-come-true ?character - character)
  )

  ;; A character gets accepted to university.
  (:action get-accepted
    :parameters
      (?character - character)
    :precondition
      (and (worried ?character)
      (hardworking ?character))
    :effect
      (and (accepted-to-university ?character)
      (not (worried ?character))
      (happy ?character))
    :agents
      (?character)
  )

  ;; A character starts applauding.
  (:action start-applauding
    :parameters
      (?character - character ?other - character)
    :precondition
      (and (not (applauding ?character))
      (happy ?other))
    :effect
      (applauding ?character)
    :agents
      (?character)
  )

  ;; A character stops applauding.
  (:action stop-applauding
    :parameters
      (?character - character)
    :precondition
      (applauding ?character)
    :effect
      (not (applauding ?character))
    :agents
      (?character)
  )

  ;; A character's dreams come true.
  (:action make-dreams-come-true
    :parameters
      (?character - character)
    :precondition
      (and (accepted-to-university ?character)
      (hardworking ?character))
    :effect
      (dreams-come-true ?character)
    :agents
      (?character)
  )
)