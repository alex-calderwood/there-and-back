(define (domain park-swing)
  (:requirements :strips :typing)
  (:types friend - object)
  (:predicates
    (on-swing ?friend - friend)
    (at-park))

  ;; A friend gets on the swing.
  (:action get-on-swing
    :parameters
      (?friend - friend)
    :precondition
      (and (at-park)
      (not (on-swing ?friend)))
    :effect
      (on-swing ?friend)
  )

  ;; A friend gets off the swing.
  (:action get-off-swing
    :parameters
      (?friend - friend)
    :precondition
      (on-swing ?friend)
    :effect
      (not (on-swing ?friend))
  )

  ;; A friend pushes another friend on the swing.
  (:action push-swing
    :parameters
      (?friend1 - friend ?friend2 - friend)
    :precondition
      (and (on-swing ?friend2)
      (not (= ?friend1 ?friend2)))
    :effect
      (on-swing ?friend1)
  )
)