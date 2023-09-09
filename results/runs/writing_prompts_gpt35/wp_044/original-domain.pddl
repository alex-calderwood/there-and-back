(define (domain immortal-prisoner)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants serum - expression)
  (:predicates
    (imprisoned ?character - character)
    (alive ?character - character)
    (dosage ?character - character ?serum - expression)
    (has ?character - character ?serum - expression)
    (believes ?character - character ?expression - expression)
    (intends ?character - character ?expression - expression)
  )

  ;; A character takes a dosage of the serum.
  (:action take-dosage
    :parameters
      (?character - character ?serum - expression)
    :precondition
      (and (alive ?character)
      (has ?character ?serum))
    :effect
      (dosage ?character ?serum)
    :agents
      (?character)
  )

  ;; A character is imprisoned.
  (:action imprison
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (imprisoned ?character)
    :agents
      (?character)
  )

  ;; A character is released from prison.
  (:action release
    :parameters
      (?character - character)
    :precondition
      (and (imprisoned ?character)
      (alive ?character))
    :effect
      (not (imprisoned ?character))
    :agents
      (?character)
  )

  ;; A character believes an expression.
  (:action believe
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (alive ?character)
    :effect
      (believes ?character ?expression)
    :agents
      (?character)
  )

  ;; A character intends an expression.
  (:action intend
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (alive ?character)
    :effect
      (intends ?character ?expression)
    :agents
      (?character)
  )

  ;; An expression is true.
  (:axiom
    :vars
      (?expression - expression)
    :context
      (and (not (believes ?character ?expression))
      (forall (?character - character)
      (dosage ?character ?serum)
      (intends ?character ?expression)))
    :implies
      (believes ?character ?expression)
  )
)