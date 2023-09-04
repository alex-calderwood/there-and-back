(define (domain timmy-park)
  (:requirements :strips :typing :equality)
  (:types person - object)
  (:predicates
    (at ?person - person ?location - object)
    (in-park ?person - person)
    (watching ?person - person)
    (playing ?person - person)
    (throwing ?person - person)
    (happy ?person - person)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; A person starts playing in the park.
  (:action start-playing
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (in-park ?person)
      (at ?person ?location)
      (not (playing ?person)))
    :effect
      (playing ?person)
  )

  ;; A person stops playing in the park.
  (:action stop-playing
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (in-park ?person)
      (at ?person ?location)
      (playing ?person))
    :effect
      (not (playing ?person))
  )

  ;; A person starts throwing a ball.
  (:action start-throwing
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (in-park ?person)
      (at ?person ?location)
      (playing ?person)
      (not (throwing ?person)))
    :effect
      (throwing ?person)
  )

  ;; A person stops throwing a ball.
  (:action stop-throwing
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (in-park ?person)
      (at ?person ?location)
      (playing ?person)
      (throwing ?person))
    :effect
      (not (throwing ?person))
  )

  ;; A person becomes happy.
  (:action become-happy
    :parameters
      (?person - person ?location - object)
    :precondition
      (and (in-park ?person)
      (at ?person ?location)
      (playing ?person)
      (throwing ?person)
      (not (happy ?person)))
    :effect
      (happy ?person)
  )

  ;; A person watches another person.
  (:action watch
    :parameters
      (?watcher - person ?watchee - person ?location - object)
    :precondition
      (and (in-park ?watcher)
      (at ?watcher ?location)
      (in-park ?watchee)
      (at ?watchee ?location)
      (playing ?watchee))
    :effect
      (watching ?watcher)
  )
)