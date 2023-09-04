(define (problem truck-driver-problem)
  (:domain truck-driver)
  (:objects
    harry - character
    city-critters - character
  )
  (:init
    (intends harry (drives harry peterbuilt))
    (intends harry (listens-to harry skynyrd))
    (intends harry (listens-to harry seger))
    (intends harry (not (intends harry (drives harry peterbuilt)))))
  (:goal
    (and (drives harry peterbuilt)
    (listens-to harry skynyrd)
    (listens-to harry seger)
    (not (intends harry (drives harry peterbuilt)))))
)