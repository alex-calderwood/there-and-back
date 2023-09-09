(define (domain afterlife)
  (:requirements :adl :expression-variables)
  (:types person - object)
  (:constants
    afterlife - person
    universe - expression)
  (:predicates
    (in-afterlife ?person - person)
    (part-of-universe ?person - person ?universe - expression)
    (enjoying-life ?person - person)
    (happy ?person - person)
    (alive ?person - person)
    (dead ?person - person)
    (resurrected ?person - person)
  )

  ;; A person dies and enters the afterlife.
  (:action die
    :parameters
      (?person - person)
    :precondition
      (alive ?person)
    :effect
      (and (not (alive ?person))
      (in-afterlife ?person))
    :agents
      (?person)
  )

  ;; A person becomes a part of the universe.
  (:action become-part-of-universe
    :parameters
      (?person - person ?universe - expression)
    :precondition
      (in-afterlife ?person)
    :effect
      (part-of-universe ?person ?universe)
    :agents
      (?person)
  )

  ;; A person enjoys life.
  (:action enjoy-life
    :parameters
      (?person - person)
    :precondition
      (and (in-afterlife ?person)
      (part-of-universe ?person universe))
    :effect
      (enjoying-life ?person)
    :agents
      (?person)
  )

  ;; A person is happy.
  (:action be-happy
    :parameters
      (?person - person)
    :precondition
      (enjoying-life ?person)
    :effect
      (happy ?person)
    :agents
      (?person)
  )

  ;; A person is resurrected.
  (:action resurrect
    :parameters
      (?person - person)
    :precondition
      (dead ?person)
    :effect
      (and (not (dead ?person))
      (resurrected ?person))
    :agents
      (?person)
  )
)