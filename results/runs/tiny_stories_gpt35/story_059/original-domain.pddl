(define (domain kitty-and-buddy-puzzle)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :expression-variables :intentionality)
  (:types animal - object)
  (:predicates
    (has-puzzle-piece ?animal - animal)
    (put-together-puzzle)
    (friends ?animal1 - animal ?animal2 - animal)
    (at ?animal - animal ?location - object)
    (intends ?animal - animal ?predicate - predicate)
    (alive ?animal - animal)
  )

  ;; An animal travels from one location to another.
  (:action travel
    :parameters
      (?animal - animal ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?animal)
      (at ?animal ?from))
    :effect
      (and (not (at ?animal ?from))
      (at ?animal ?to))
    :agents
      (?animal)
  )

  ;; An animal picks up a puzzle piece.
  (:action pick-up-piece
    :parameters
      (?animal - animal ?piece - object ?location - object)
    :precondition
      (and (alive ?animal)
      (at ?animal ?location)
      (at ?piece ?location))
    :effect
      (and (not (at ?piece ?location))
      (has-puzzle-piece ?animal ?piece))
    :agents
      (?animal)
  )

  ;; An animal puts a puzzle piece together with another.
  (:action put-together
    :parameters
      (?animal1 - animal ?animal2 - animal ?piece1 - object ?piece2 - object)
    :precondition
      (and (alive ?animal1)
      (alive ?animal2)
      (at ?animal1 ?location)
      (at ?animal2 ?location)
      (has-puzzle-piece ?animal1 ?piece1)
      (has-puzzle-piece ?animal2 ?piece2)
      (not (= ?animal1 ?animal2))
      (not (= ?piece1 ?piece2)))
    :effect
      (and (not (has-puzzle-piece ?animal1 ?piece1))
      (not (has-puzzle-piece ?animal2 ?piece2))
      (put-together-puzzle))
    :agents
      (?animal1 ?animal2)
  )

  ;; Two animals become friends.
  (:action become-friends
    :parameters
      (?animal1 - animal ?animal2 - animal)
    :precondition
      (and (alive ?animal1)
      (alive ?animal2)
      (not (= ?animal1 ?animal2)))
    :effect
      (and (friends ?animal1 ?animal2)
      (friends ?animal2 ?animal1))
    :agents
      (?animal1 ?animal2)
  )
)