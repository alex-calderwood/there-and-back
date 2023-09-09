(define (domain immortal-child)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (immortal ?character - character)
    (thirsty ?character - character)
    (greedy ?character - character)
    (judging ?character - character)
    (communicating ?character - character)
    (pleasing ?character - character)
    (replaced ?character - character)
    (free ?character - character)
  )

  ;; A character becomes immortal.
  (:action become-immortal
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (immortal ?character)
    :agents
      (?character)
  )

  ;; A character becomes thirsty.
  (:action become-thirsty
    :parameters
      (?character - character)
    :precondition
      (immortal ?character)
    :effect
      (thirsty ?character)
    :agents
      (?character)
  )

  ;; A character becomes greedy.
  (:action become-greedy
    :parameters
      (?character - character)
    :precondition
      (thirsty ?character)
    :effect
      (greedy ?character)
    :agents
      (?character)
  )

  ;; A character judges another.
  (:action judge
    :parameters
      (?judger - character ?judged - character)
    :precondition
      (and (alive ?judger)
      (alive ?judged))
    :effect
      (judging ?judger)
    :agents
      (?judger)
  )

  ;; A character communicates with another.
  (:action communicate
    :parameters
      (?communicator - character ?receiver - character)
    :precondition
      (and (alive ?communicator)
      (alive ?receiver))
    :effect
      (communicating ?communicator)
    :agents
      (?communicator)
  )

  ;; A character tries to please another.
  (:action try-to-please
    :parameters
      (?pleaser - character ?pleased - character)
    :precondition
      (and (alive ?pleaser)
      (alive ?pleased))
    :effect
      (pleasing ?pleaser)
    :agents
      (?pleaser)
  )

  ;; A character replaces another.
  (:action replace
    :parameters
      (?replacer - character ?replaced - character)
    :precondition
      (and (alive ?replacer)
      (alive ?replaced))
    :effect
      (replaced ?replaced)
    :agents
      (?replacer)
  )

  ;; A character becomes free.
  (:action become-free
    :parameters
      (?character - character)
    :precondition
      (replaced ?character)
    :effect
      (free ?character)
    :agents
      (?character)
  )
)