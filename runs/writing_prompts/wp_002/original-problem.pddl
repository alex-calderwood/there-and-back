(define (problem mathematical-love-problem)
  (:domain
    mathematical-love)
  (:objects
    character1 character2 character3 - character)
  (:init
    (solitary character1)
    (solitary character2)
    (solitary character3)
    (intends character1 (connected character1 character2))
    (intends character2 (connected character1 character2))
    (intends character1 (differentiate character1 character3))
    (intends character3 (differentiate character1 character3))
    (intends character1 (find-integral-partner character1 character2))
    (intends character2 (find-integral-partner character1 character2))
    (intends character1 (become-fated character1))
    (intends character2 (become-paired character1 character2))
    (intends character3 (become-paired character1 character2))
  )
  (:goal
    (and (paired character1 character2)
    (fated character3))
  )
)