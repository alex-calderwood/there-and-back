(define (domain helping-a-friend)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types person - object)
  (:predicates
    (smiling ?person - person)
    (laughing ?person - person)
    (needing-help ?person - person)
    (has-time ?person - person)
    (has-friend ?person - person)
    (willing-to-help ?person - person)
  )

  ;; A person talks to another person.
  (:action talk
    :parameters
      (?talker - person ?listener - person)
    :precondition
      (and (has-friend ?talker ?listener)
      (has-time ?talker)
      (needing-help ?listener))
    :effect
      (and (not (needing-help ?listener))
      (willing-to-help ?talker ?listener))
    :agents
      (?talker)
  )

  ;; A person makes another person smile.
  (:action make-smile
    :parameters
      (?maker - person ?receiver - person)
    :precondition
      (and (willing-to-help ?maker ?receiver)
      (has-time ?maker))
    :effect
      (smiling ?receiver)
    :agents
      (?maker)
  )

  ;; A person makes another person laugh.
  (:action make-laugh
    :parameters
      (?maker - person ?receiver - person)
    :precondition
      (and (willing-to-help ?maker ?receiver)
      (has-time ?maker)
      (smiling ?receiver))
    :effect
      (laughing ?receiver)
    :agents
      (?maker)
  )
)