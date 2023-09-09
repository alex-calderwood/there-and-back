(define (domain kitty-and-doggy)
  (:requirements :strips :typing :equality)
  (:types animal - object)
  (:predicates
    (at ?animal - animal ?location - object)
    (has-help ?animal - animal)
    (has-yarn ?animal - animal)
    (playing ?animal - animal)
  )

  ;; An animal moves from one location to another.
  (:action move
    :parameters
      (?animal - animal ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?animal ?from))
    :effect
      (and (not (at ?animal ?from))
      (at ?animal ?to))
  )

  ;; An animal asks for help from another animal.
  (:action ask-for-help
    :parameters
      (?asking-animal - animal ?helping-animal - animal)
    :precondition
      (and (not (= ?asking-animal ?helping-animal))
      (at ?asking-animal ?location)
      (at ?helping-animal ?location))
    :effect
      (has-help ?asking-animal)
    :agents
      (?asking-animal ?helping-animal)
  )

  ;; An animal plays with a ball of yarn.
  (:action play-with-yarn
    :parameters
      (?animal - animal)
    :precondition
      (and (has-yarn ?animal)
      (has-help ?animal)
      (at ?animal ?location))
    :effect
      (playing ?animal)
  )

  ;; An animal stops playing with a ball of yarn.
  (:action stop-playing
    :parameters
      (?animal - animal)
    :precondition
      (playing ?animal)
    :effect
      (not (playing ?animal))
  )
)