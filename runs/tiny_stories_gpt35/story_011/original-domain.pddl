(define (domain garden)
  (:requirements :strips :typing :equality)
  (:types object - physical-object animal - object cat bird - animal)
  (:predicates
    (asleep ?animal - animal)
    (awake ?animal - animal)
    (playing ?animal - animal)
    (friend ?animal - animal)
    (under ?object - physical-object ?object - physical-object)
    (on ?animal - animal ?object - physical-object)
  )

  ;; A cat falls asleep under a tree.
  (:action fall-asleep
    :parameters
      (?cat - cat ?tree - physical-object)
    :precondition
      (and (not (awake ?cat))
      (not (on ?cat ?tree)))
    :effect
      (and (asleep ?cat)
      (under ?cat ?tree))
    :agents
      (?cat)
  )

  ;; A cat wakes up.
  (:action wake-up
    :parameters
      (?cat - cat)
    :precondition
      (asleep ?cat)
    :effect
      (and (awake ?cat)
      (not (asleep ?cat)))
    :agents
      (?cat)
  )

  ;; A bird sings to a cat.
  (:action sing
    :parameters
      (?bird - bird ?cat - cat)
    :precondition
      (and (not (friend ?bird ?cat))
      (awake ?cat)
      (on ?bird ?object)
      (on ?cat ?object))
    :effect
      (and (friend ?bird ?cat)
      (playing ?bird)
      (playing ?cat))
    :agents
      (?bird ?cat)
  )
)