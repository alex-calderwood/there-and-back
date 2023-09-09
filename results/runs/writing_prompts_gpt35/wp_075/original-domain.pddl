(define (domain state-of-the-union)
  (:requirements :adl :expression-variables :intentionality)
  (:types person - object)
  (:constants
    president speaker vp - person
    planned-parenthood prison - expression
  )
  (:predicates
    (alive ?person - person)
    (at ?person - person ?place - expression)
    (intends ?person - person ?expression - expression)
    (funded ?expression - expression)
    (criminalized ?expression - expression)
    (defunded ?expression - expression)
    (shut-down ?expression - expression)
    (bloated ?expression - expression)
    (political-prisoner ?person - person)
  )

  ;; A person travels from one place to another.
  (:action travel
    :parameters
      (?person - person ?from - expression ?to - expression)
    :precondition
      (and (not (= ?from ?to))
      (alive ?person)
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
    :agents  (?person)
  )

  ;; A person funds an expression.
  (:action fund
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (alive ?person)
      (intends ?person (not (defunded ?expression))))
    :effect
      (funded ?expression)
    :agents  (?person)
  )

  ;; An expression is defunded.
  (:action defund
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (alive ?person)
      (intends ?person (not (funded ?expression)))))
    :effect
      (defunded ?expression)
    :agents  (?person)
  )

  ;; An expression is criminalized.
  (:action criminalize
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (alive ?person)
      (intends ?person (not (criminalized ?expression)))))
    :effect
      (criminalized ?expression)
    :agents  (?person)
  )

  ;; An expression is shut down.
  (:action shut-down
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (alive ?person)
      (intends ?person (not (shut-down ?expression)))))
    :effect
      (shut-down ?expression)
    :agents  (?person)
  )

  ;; An expression is bloated.
  (:action bloat
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (alive ?person)
      (intends ?person (not (bloated ?expression)))))
    :effect
      (bloated ?expression)
    :agents  (?person)
  )

  ;; A person is made into a political prisoner.
  (:action imprison
    :parameters
      (?person - person)
    :precondition
      (and (alive ?person)
      (intends ?person (not (political-prisoner ?person)))))
    :effect
      (political-prisoner ?person)
    :agents  (?person)
  )
)