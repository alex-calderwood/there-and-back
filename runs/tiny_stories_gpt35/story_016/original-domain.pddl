(define (domain prince-story)
  (:requirements :strips :typing :negative-preconditions :intentionality)
  (:types person - object)
  (:predicates
    (talked-to ?person - person)
    (tricked ?person - person)
    (cried ?person - person)
    (happy ?person - person)
    (wise ?person - person)
  )

  ;; A person talks to another person.
  (:action talk
    :parameters
      (?talker - person ?listener - person)
    :precondition
      (and (not (= ?talker ?listener))
      (not (tricked ?talker))
      (not (tricked ?listener)))
    :effect
      (talked-to ?talker ?listener)
    :agents
      (?talker)
  )

  ;; A person is tricked by another person.
  (:action trick
    :parameters
      (?tricker - person ?tricked - person)
    :precondition
      (and (not (= ?tricker ?tricked))
      (talked-to ?tricker ?tricked))
    :effect
      (tricked ?tricked)
    :agents
      (?tricker)
  )

  ;; A person cries.
  (:action cry
    :parameters
      (?person - person)
    :precondition
      (and (not (cried ?person))
      (tricked ?person))
    :effect
      (cried ?person)
    :agents
      (?person)
  )

  ;; A person becomes wise.
  (:action become-wise
    :parameters
      (?person - person)
    :precondition
      (and (not (wise ?person))
      (not (cried ?person)))
    :effect
      (wise ?person)
    :agents
      (?person)
  )

  ;; A person becomes happy.
  (:action become-happy
    :parameters
      (?person - person)
    :precondition
      (and (not (happy ?person))
      (wise ?person))
    :effect
      (happy ?person)
    :agents
      (?person)
  )
)