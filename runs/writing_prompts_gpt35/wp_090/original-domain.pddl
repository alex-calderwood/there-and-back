(define (domain obama-election)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object)
  (:constants obama - person)
  (:predicates
    (famous ?person - person)
    (winning ?person - person)
    (burning ?person - person)
    (succeeding ?person - person)
    (hearing ?person - person)
  )

  ;; A person wins the election.
  (:action win-election
    :parameters
      (?person - person)
    :precondition
      (and (famous ?person)
      (not (winning ?person)))
    :effect
      (and (winning ?person)
      (not (burning ?person)))
  )

  ;; A person loses the election and suffers the infamous burning.
  (:action lose-election
    :parameters
      (?person - person)
    :precondition
      (and (famous ?person)
      (not (burning ?person)))
    :effect
      (and (burning ?person)
      (not (hearing ?person)))
  )

  ;; A person succeeds in winning the election.
  (:action succeed-election
    :parameters
      (?person - person)
    :precondition
      (and (winning ?person)
      (not (succeeding ?person)))
    :effect
      (succeeding ?person)
  )

  ;; A person hears the words "President Obama."
  (:action hear-president
    :parameters
      (?person - person)
    :precondition
      (and (succeeding obama)
      (burning ?person)
      (not (hearing ?person)))
    :effect
      (hearing ?person)
  )
)