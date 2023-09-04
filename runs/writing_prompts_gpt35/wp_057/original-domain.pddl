(define (domain alien-liberation)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants alien - character)
  (:predicates
    (speaks ?character - character ?language - expression)
    (alive ?character - character)
    (oppressed ?character - character)
    (knows ?character - character ?expression - expression)
    (believes ?character - character ?expression - expression)
    (intends ?character - character ?expression - expression)
    (visible ?expression - expression)
  )

  ;; A character speaks a language.
  (:action speak
    :parameters
      (?character - character ?language - expression)
    :precondition
      (alive ?character)
    :effect
      (speaks ?character ?language)
    :agents
      (?character)
  )

  ;; A character disappears.
  (:action disappear
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (not (visible ?character))
    :agents
      (?character)
  )

  ;; A character is liberated.
  (:action liberate
    :parameters
      (?liberator - character ?oppressed - character)
    :precondition
      (and (alive ?liberator)
      (alive ?oppressed)
      (oppressed ?oppressed)
      (knows ?liberator (visible ?oppressed)))
    :effect
      (and (not (oppressed ?oppressed))
      (believes ?oppressed (not (oppressed ?oppressed))))
    :agents
      (?liberator)
  )

  ;; A character learns an expression.
  (:action learn
    :parameters
      (?learner - character ?expression - expression)
    :precondition
      (alive ?learner)
    :effect
      (knows ?learner ?expression)
    :agents
      (?learner)
  )

  ;; A character believes an expression.
  (:action believe
    :parameters
      (?believer - character ?expression - expression)
    :precondition
      (alive ?believer)
    :effect
      (believes ?believer ?expression)
    :agents
      (?believer)
  )

  ;; A character intends an expression.
  (:action intend
    :parameters
      (?intender - character ?expression - expression)
    :precondition
      (alive ?intender)
    :effect
      (intends ?intender ?expression)
    :agents
      (?intender)
  )

  ;; A character expresses an expression.
  (:action express
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (and (alive ?character)
      (speaks ?character ?expression)
      (intends ?character ?expression))
    :effect
      (visible ?expression)
    :agents
      (?character)
  )
)