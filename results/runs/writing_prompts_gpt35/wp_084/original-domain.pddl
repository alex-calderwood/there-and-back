(define (domain love-confession)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types person - object)
  (:predicates
    (loves ?person1 - person ?person2 - person)
    (has-obstruction)
    (choked)
    (answered ?person - person)
    (confessed ?person - person)
    (close ?person1 - person ?person2 - person)
  )

  ;; A person confesses their love to another.
  (:action confess-love
    :parameters
      (?confessor - person ?confessee - person)
    :precondition
      (and (not (answered ?confessee))
      (not (has-obstruction))
      (not (choked))
      (close ?confessor ?confessee))
    :effect
      (and (confessed ?confessor)
      (loves ?confessor ?confessee))
    :agents
      (?confessor)
  )

  ;; A person chokes while confessing their love.
  (:action choke
    :parameters
      (?person - person)
    :precondition
      (and (confessed ?person)
      (not (has-obstruction)))
    :effect
      (choked)
    :agents
      (?person)
  )

  ;; A person removes their obstruction.
  (:action remove-obstruction
    :parameters
      (?person - person)
    :precondition
      (has-obstruction)
    :effect
      (not (has-obstruction))
    :agents
      (?person)
  )
)