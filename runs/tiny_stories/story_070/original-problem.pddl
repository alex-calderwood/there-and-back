(define (problem cat-dog-wrap)
  (:domain
    cat-dog-wrap)
  (:objects
    cat dog - character
    wrap - item)
  (:init
    (has cat wrap)
    (clean wrap)
    (intends dog (has dog wrap))
    (steal-intention dog wrap))
  (:goal
    (and (friends cat dog)
    (has cat wrap)
    (clean wrap)
    (not (steal-intention dog wrap))))
)