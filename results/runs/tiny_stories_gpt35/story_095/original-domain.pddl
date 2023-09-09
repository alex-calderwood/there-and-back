(define (domain cat-and-dog)
  (:requirements :strips :typing :equality)
  (:types cat dog - animal seat ball - object)
  (:predicates
    (at ?animal - animal ?place - object)
    (broken ?seat - seat)
    (sitting ?animal - animal ?seat - seat)
  )

  ;; A cat walks to a seat.
  (:action walk-to-seat
    :parameters
      (?cat - cat ?seat - seat ?place - object)
    :precondition
      (and (at ?cat ?place)
      (at ?seat ?place))
    :effect
      (and (not (at ?cat ?place))
      (at ?cat ?seat))
    :agents
      (?cat)
  )

  ;; A dog sits on a seat.
  (:action sit-on-seat
    :parameters
      (?dog - dog ?seat - seat ?place - object)
    :precondition
      (and (at ?dog ?place)
      (at ?seat ?place)
      (not (sitting ?dog ?seat)))
    :effect
      (sitting ?dog ?seat)
    :agents
      (?dog)
  )

  ;; A ball falls from the sky and breaks a seat.
  (:action ball-falls
    :parameters
      (?ball - ball ?seat - seat ?place - object)
    :precondition
      (and (at ?ball ?place)
      (not (broken ?seat)))
    :effect
      (and (broken ?seat)
      (not (at ?ball ?place)))
    :agents
      ()
  )
)