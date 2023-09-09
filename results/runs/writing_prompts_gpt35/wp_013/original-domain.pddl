(define (domain crow-mind)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types body-part - object)
  (:predicates
    (has-feathers)
    (perched)
    (alive)
    (has-pain ?body-part - body-part)
    (has-print ?body-part - body-part)
    (has-countdown)
    (has-flash)
    (has-breath)
    (has-life)
  )

  ;; The crow mind takes over the body.
  (:action take-over
    :parameters
      (?body-part - body-part)
    :precondition
      (and (alive)
      (not (has-feathers))
      (not (perched))
      (not (has-pain ?body-part))
      (not (has-print ?body-part))
      (not (has-countdown))
      (not (has-flash))
      (not (has-breath))
      (not (has-life)))
    :effect
      (and (has-feathers)
      (perched)
      (not (alive))
      (has-pain ?body-part)
      (has-print ?body-part)
      (has-countdown)
      (has-flash)
      (has-breath)
      (not (has-life)))
  )

  ;; The crow mind leaves the body.
  (:action leave
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive))
      (has-pain ?body-part)
      (has-print ?body-part)
      (has-countdown)
      (has-flash)
      (has-breath)
      (not (has-life))))
    :effect
      (and (not (has-feathers))
      (not (perched))
      (alive)
      (not (has-pain ?body-part))
      (not (has-print ?body-part))
      (not (has-countdown))
      (not (has-flash))
      (not (has-breath))
      (has-life))
  )

  ;; The crow mind preens its feathers.
  (:action preen
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive)))
    :effect
      (not (has-pain ?body-part))
    :agents
      (crow-mind)
  )

  ;; The crow mind focuses on a target.
  (:action focus
    :parameters
      (?target - object)
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive)))
    :effect
      (not (has-print ?body-part))
    :agents
      (crow-mind)
  )

  ;; The crow mind starts a countdown.
  (:action start-countdown
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive)))
    :effect
      (has-countdown)
    :agents
      (crow-mind)
  )

  ;; The crow mind sees a flash of light.
  (:action see-flash
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive))
      (has-countdown))
    :effect
      (has-flash)
    :agents
      (crow-mind)
  )

  ;; The crow mind takes a breath.
  (:action take-breath
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive))
      (has-flash))
    :effect
      (has-breath)
    :agents
      (crow-mind)
  )

  ;; The crow mind leaves the body.
  (:action end
    :precondition
      (and (has-feathers)
      (perched)
      (not (alive))
      (has-breath))
    :effect
      (has-life)
    :agents
      (crow-mind)
  )
)