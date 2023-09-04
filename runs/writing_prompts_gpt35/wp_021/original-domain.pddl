(define (domain drug-dealer)
  (:requirements :adl :expression-variables :intentionality)
  (:types person - object drug - item)
  (:constants 
    heroin cocaine - drug)
  (:predicates
    (has ?person - person ?drug - drug)
    (intends ?person - person ?predicate - predicate)
    (in-withdrawal ?person - person)
    (in-bed ?person - person)
    (craves ?person - person ?drug - drug)
    (feels ?person - person ?expression - expression)
  )

  ;; A person sells drugs to another person.
  (:action sell
    :parameters
      (?seller - person ?buyer - person ?drug - drug)
    :precondition
      (and (intends ?seller (has ?buyer ?drug))
      (intends ?buyer (craves ?buyer ?drug)))
    :effect
      (and (has ?buyer ?drug)
      (not (intends ?seller (has ?buyer ?drug)))
      (not (intends ?buyer (craves ?buyer ?drug))))
    :agents
      (?seller ?buyer)
  )

  ;; A person takes drugs.
  (:action take
    :parameters
      (?person - person ?drug - drug)
    :precondition
      (and (has ?person ?drug)
      (not (in-withdrawal ?person))))
    :effect
      (and (in-bed ?person)
      (not (has ?person ?drug))
      (intends ?person (in-withdrawal ?person))
      (intends ?person (feels ?person (expression "high"))))
    :agents
      (?person)
  )

  ;; A person experiences withdrawal symptoms.
  (:action withdrawal
    :parameters
      (?person - person)
    :precondition
      (in-withdrawal ?person)
    :effect
      (not (in-withdrawal ?person))
    :agents
      (?person)
  )

  ;; A person craves a drug.
  (:action crave
    :parameters
      (?person - person ?drug - drug)
    :precondition
      (and (not (has ?person ?drug))
      (not (in-withdrawal ?person)))
    :effect
      (intends ?person (craves ?person ?drug))
    :agents
      (?person)
  )

  ;; A person relives a drug experience.
  (:action relive
    :parameters
      (?person - person ?expression - expression)
    :precondition
      (and (in-bed ?person)
      (feels ?person ?expression))
    :effect
      (not (in-bed ?person))
    :agents
      (?person)
  )
)