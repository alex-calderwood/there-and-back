(define (problem jack-and-his-friend)
  (:domain
    jack-and-his-friend)
  (:objects
    jack friend - character)
  (:init
    (alive jack)
    (alive friend)
    (intends jack (looking-back jack))
    (intends jack (watching-out jack))
    (intends jack (become-cautious jack))
    (intends friend (give-snack friend jack (lying friend snack)))
    (intends friend (become-disappointed friend))
    (intends friend (lie friend snack))
    (intends friend (not (compassionate friend)))
    (intends friend (not (watching-out friend))))
  (:goal
    (and (crying jack)
    (disappointed jack)
    (looking-back jack)
    (cautious jack))
  )
)