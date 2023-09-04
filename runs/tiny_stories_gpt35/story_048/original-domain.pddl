(define (domain park-playtime)
  (:requirements :strips :typing :equality)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (wet ?location - object)
    (dry ?location - object)
    (crying ?person - person)
    (scared ?person - person)
    (playing ?person - person)
    (best-friends ?person1 - person ?person2 - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect  (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person dries a wet location with their hands.
  (:action dry
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (at ?person ?location)
      (wet ?location))
    :effect
      (and (not (wet ?location))
      (dry ?location))
  )

  ;; A person stops crying.
  (:action stop-crying
    :parameters
      (?person - person)
    :precondition
      (crying ?person)
    :effect
      (not (crying ?person))
  )

  ;; Two people become best friends.
  (:action become-best-friends
    :parameters
      (?person1 - person ?person2 - person)
    :precondition
      (and (not (= ?person1 ?person2))
      (at ?person1 ?location)
      (at ?person2 ?location)
      (not (best-friends ?person1 ?person2)))
    :effect
      (and (best-friends ?person1 ?person2)
      (best-friends ?person2 ?person1))
  )

  ;; A person plays.
  (:action play
    :parameters
      (?person - person)
    :precondition
      (and (not (crying ?person))
      (not (scared ?person))
      (at ?person ?location)
      (dry ?location))
    :effect
      (playing ?person)
  )
)