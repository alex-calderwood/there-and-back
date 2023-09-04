(define (domain tim-and-puppy)
  (:requirements :strips :typing :equality)
  (:types object - physical-object animal - object person - object)
  (:predicates
    (at ?object - object ?place - object)
    (tired ?animal - animal)
    (asleep ?animal - animal)
    (awake ?animal - animal)
    (happy ?person - person)
    (scared ?person - person)
    (friend ?person - person ?animal - animal)
  )

  ;; A person travels from one place to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
    :agents  (?person)
  )

  ;; A person touches an object.
  (:action touch
    :parameters
      (?person - person ?object - object)
    :precondition
      (and (at ?person ?object))
    :effect
      (and (not (scared ?person))
      (not (at ?object ?place)))
    :agents  (?person)
  )

  ;; An animal wakes up.
  (:action wake-up
    :parameters
      (?animal - animal)
    :precondition
      (asleep ?animal)
    :effect
      (and (not (asleep ?animal))
      (awake ?animal))
  )

  ;; A person becomes happy.
  (:action become-happy
    :parameters
      (?person - person)
    :precondition
      (and (not (scared ?person))
      (friend ?person ?animal)
      (awake ?animal))
    :effect
      (happy ?person)
    :agents  (?person)
  )

  ;; A person becomes scared.
  (:action become-scared
    :parameters
      (?person - person)
    :precondition
      (scared ?person)
    :effect
      (not (happy ?person))
    :agents  (?person)
  )

  ;; A person becomes friends with an animal.
  (:action become-friends
    :parameters
      (?person - person ?animal - animal)
    :precondition
      (and (at ?person ?place)
      (at ?animal ?place)
      (not (scared ?person))
      (not (scared ?animal)))
    :effect
      (and (friend ?person ?animal)
      (friend ?animal ?person))
    :agents
      (?person ?animal)
  )
)