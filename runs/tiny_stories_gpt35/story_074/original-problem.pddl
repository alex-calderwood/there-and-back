(define (problem magic-bird-wish)
  (:domain magic-bird)
  (:objects
    lucy mother - person
    bird - object)
  (:init
    (small bird)
    (has-snack mother)
    (has-snack lucy)
    (intends lucy (shared-snack lucy))
    (intends mother (shared-snack mother))
    (intends lucy (not (has-snack lucy)))
    (intends mother (not (has-snack mother)))
    (intends lucy (not (small bird)))
    (intends bird (big bird)))
  (:goal
    (and (wish-granted)))
)