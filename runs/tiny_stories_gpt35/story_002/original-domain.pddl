(define (domain bird-adventure)
  (:requirements :strips :typing :equality)
  (:types bird - object)
  (:predicates
    (sailing ?bird - bird)
    (playing ?bird - bird)
    (friend ?bird1 - bird ?bird2 - bird)
  )

  ;; A bird starts sailing in the sky.
  (:action start-sailing
    :parameters
      (?bird - bird)
    :precondition
      (not (sailing ?bird))
    :effect
      (sailing ?bird)
  )

  ;; A bird stops sailing in the sky.
  (:action stop-sailing
    :parameters
      (?bird - bird)
    :precondition
      (sailing ?bird)
    :effect
      (not (sailing ?bird))
  )

  ;; Two birds become friends.
  (:action make-friends
    :parameters
      (?bird1 - bird ?bird2 - bird)
    :precondition
      (and (not (friend ?bird1 ?bird2))
      (not (= ?bird1 ?bird2)))
    :effect
      (and (friend ?bird1 ?bird2)
      (friend ?bird2 ?bird1))
  )

  ;; A bird starts playing.
  (:action start-playing
    :parameters
      (?bird - bird)
    :precondition
      (and (sailing ?bird)
      (not (playing ?bird)))
    :effect
      (playing ?bird)
  )

  ;; A bird stops playing.
  (:action stop-playing
    :parameters
      (?bird - bird)
    :precondition
      (playing ?bird)
    :effect
      (not (playing ?bird))
  )
)