(define (problem jack-learns-lesson)
  (:domain
    jack-and-the-lie)
  (:objects
    jack friend - character)
  (:init
    (happy jack)
    (at jack friend)
    (compassionate friend)
    (trusts jack friend))
  (:goal
    (and (not (at jack friend))
    (not (trusts jack friend))
    (happy jack)))
)