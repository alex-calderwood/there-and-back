(define (domain pin-rescue)
  (:requirements :strips :typing :equality)
  (:types pin - object)
  (:predicates
    (in-box ?pin - pin)
    (on-floor ?pin - pin)
    (alive ?pin - pin)
  )

  ;; A pin is moved from the floor to the box.
  (:action move-to-box
    :parameters
      (?pin - pin)
    :precondition
      (and (on-floor ?pin)
      (not (in-box ?pin)))
    :effect
      (and (not (on-floor ?pin))
      (in-box ?pin))
  )

  ;; A pin is moved from the box to the floor.
  (:action move-to-floor
    :parameters
      (?pin - pin)
    :precondition
      (and (in-box ?pin)
      (not (on-floor ?pin)))
    :effect
      (and (not (in-box ?pin))
      (on-floor ?pin))
  )

  ;; A pin is brought to life.
  (:action bring-to-life
    :parameters
      (?pin - pin)
    :precondition
      (and (in-box ?pin)
      (not (alive ?pin)))
    :effect
      (alive ?pin)
  )
)