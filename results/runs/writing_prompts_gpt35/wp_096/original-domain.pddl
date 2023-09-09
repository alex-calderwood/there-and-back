(define (domain magic-show)
  (:requirements :strips :negative-preconditions :typing :equality :quantified-preconditions :existential-preconditions :universal-preconditions :conditional-effects :expression-variables :intentionality)
  (:types person - object)
  (:constants assistant - person)
  (:predicates
    (at ?person - person ?location - object)
    (performing)
    (liked-performance)
    (magician ?person - person)
    (assistant ?person - person)
    (show-started)
    (show-ended)
    (show-will-continue)
    (has-performed ?person - person)
    (has-assistant ?person - person)
    (has-dreamed ?person - person)
    (has-enjoyed ?person - person)
    (has-succeeded ?person - person)
    (has-contemplated ?person - person)
    (has-achieved ?person - person)
    (intends ?person - person ?predicate - predicate)
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
    :agents
      (?person)
  )

  ;; A magician performs a magic trick.
  (:action perform
    :parameters
      (?magician - person)
    :precondition
      (and (not (performing))
      (at ?magician ?location)
      (has-assistant ?magician)
      (has-dreamed ?magician)
      (intends ?magician (has-performed ?magician)))
    :effect
      (and (performing)
      (intends ?magician (not (has-performed ?magician))))
    :agents
      (?magician)
  )

  ;; An assistant assists a magician.
  (:action assist
    :parameters
      (?assistant - person ?magician - person)
    :precondition
      (and (at ?assistant ?location)
      (at ?magician ?location)
      (has-assistant ?magician)
      (intends ?assistant (has-assisted ?magician)))
    :effect
      (intends ?assistant (not (has-assisted ?magician)))
    :agents
      (?assistant ?magician)
  )

  ;; The show starts.
  (:action start-show
    :precondition
      (and (not (show-started))
      (at ?magician ?location)
      (has-assistant ?magician))
    :effect
      (and (show-started)
      (intends ?magician (has-dreamed ?magician)))
    :agents
      (?magician)
  )

  ;; The show ends.
  (:action end-show
    :precondition
      (and (show-started)
      (performing))
    :effect
      (and (not (performing))
      (show-ended)
      (intends ?magician (has-enjoyed ?magician))
      (intends ?magician (has-succeeded ?magician)))
    :agents
      (?magician)
  )

  ;; The show will continue.
  (:action continue-show
    :precondition
      (and (show-started)
      (show-ended)
      (liked-performance))
    :effect
      (show-will-continue)
  )

  ;; A person contemplates their life.
  (:action contemplate-life
    :parameters
      (?person - person)
    :precondition
      (and (at ?person ?location)
      (has-achieved ?person))
    :effect
      (intends ?person (has-contemplated ?person))
    :agents
      (?person)
  )

  ;; A person achieves their dream.
  (:action achieve-dream
    :parameters
      (?person - person)
    :precondition
      (and (at ?person ?location)
      (has-dreamed ?person))
    :effect
      (intends ?person (has-achieved ?person))
    :agents
      (?person)
  )

  ;; A person enjoys something.
  (:action enjoy
    :parameters
      (?person - person)
    :precondition
      (and (at ?person ?location)
      (has-succeeded ?person))
    :effect
      (intends ?person (has-enjoyed ?person))
    :agents
      (?person)
  )

  ;; A person likes a performance.
  (:action like-performance
    :precondition
      (and (performing)
      (at ?person ?location))
    :effect
      (liked-performance)
    :agents
      (?person)
  )
)