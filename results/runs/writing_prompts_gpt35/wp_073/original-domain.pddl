(define (domain bill-clinton)
  (:requirements :strips :negative-preconditions :typing :equality :existential-preconditions :universal-preconditions :quantified-preconditions :expression-variables :intentionality)
  (:types person - object)
  (:constants death - person)
  (:predicates
    (is ?person - person)
    (regenerate ?person - person)
    (find ?person - person)
    (help ?person - person)
    (name ?person - person ?name - symbol)
    (wrong ?person - person)
    (replace ?person - person ?part - object)
    (repo ?person - person ?boat - object)
    (pile ?person - person ?timber - object)
    (use ?person - person ?brain - object)
    (president ?person - person)
    (intends ?person - person ?predicate - predicate)
  )

  ;; A person finds another person.
  (:action find
    :parameters
      (?finder - person ?found - person)
    :precondition
      (and (not (= ?finder ?found))
      (intends ?finder (find ?found)))
    :effect
      (and (not (intends ?finder (find ?found)))
      (intends ?found (help ?found)))
    :agents
      (?finder)
  )

  ;; A person helps another person.
  (:action help
    :parameters
      (?helper - person ?helped - person)
    :precondition
      (and (not (= ?helper ?helped))
      (intends ?helper (help ?helped)))
    :effect
      (and (not (intends ?helper (help ?helped)))
      (intends ?helped (is ?helped)))
    :agents
      (?helper)
  )

  ;; A person replaces a part of themselves.
  (:action replace
    :parameters
      (?person - person ?part - object)
    :precondition
      (and (intends ?person (replace ?person ?part)))
    :effect
      (and (not (intends ?person (replace ?person ?part)))
      (intends ?person (regenerate ?person)))
    :agents
      (?person)
  )

  ;; A person regenerates all their cells.
  (:action regenerate
    :parameters
      (?person - person)
    :precondition
      (and (intends ?person (regenerate ?person)))
    :effect
      (and (not (intends ?person (regenerate ?person)))
      (intends ?person (is ?person)))
    :agents
      (?person)
  )

  ;; A person repos a boat.
  (:action repo
    :parameters
      (?repo-man - person ?boat - object ?pile - object)
    :precondition
      (and (intends ?repo-man (repo ?repo-man ?boat))
      (not (intends ?repo-man (pile ?repo-man ?pile))))
    :effect
      (and (not (intends ?repo-man (repo ?repo-man ?boat)))
      (intends ?repo-man (pile ?repo-man ?pile)))
    :agents
      (?repo-man)
  )

  ;; A person uses their brain.
  (:action use-brain
    :parameters
      (?person - person ?brain - object)
    :precondition
      (and (intends ?person (use ?person ?brain)))
    :effect
      (and (not (intends ?person (use ?person ?brain)))
      (intends ?person (is ?person)))
    :agents
      (?person)
  )
)