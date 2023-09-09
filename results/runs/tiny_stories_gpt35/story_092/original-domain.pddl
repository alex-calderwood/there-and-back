(define (domain dan-university)
  (:requirements :adl :expression-variables :intentionality)
  (:types person - object)
  (:constants dan - person)
  (:predicates
    (happy ?person - person)
    (worried ?person - person)
    (accepted ?person - person)
    (applauding)
  )

  ;; A person receives an acceptance letter.
  (:action receive-letter
    :parameters
      (?person - person)
    :precondition
      (worried ?person)
    :effect
      (and (not (worried ?person))
      (happy ?person)
      (accepted ?person))
    :agents
      (?person)
  )

  ;; A person applauds.
  (:action applaud
    :precondition
      (and (not applauding)
      (exists (?person - person)
      (happy ?person)))
    :effect
      (applauding)
  )

  ;; A person stops applauding.
  (:action stop-applauding
    :precondition
      (applauding)
    :effect
      (not applauding)
  )

  ;; A person intends to be happy.
  (:action intend-happy
    :parameters
      (?person - person)
    :effect
      (intends ?person (happy ?person))
    :agents
      (?person)
  )

  ;; A person intends to be accepted.
  (:action intend-accepted
    :parameters
      (?person - person)
    :effect
      (intends ?person (accepted ?person))
    :agents
      (?person)
  )
)