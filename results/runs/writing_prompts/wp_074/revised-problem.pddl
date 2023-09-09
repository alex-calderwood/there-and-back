(define (problem bill-narrator-conflict)
  (:domain
    bill-and-narrator)
  (:objects
    narrator bill mom dad - character)
  (:init
    (intends narrator (despises narrator bill))
    (intends narrator (apologized narrator mom))
    (intends narrator (apologized narrator dad))
    (intends bill (influenced narrator))
    (intends bill (isolated narrator))
    (intends bill (manipulates bill narrator))
  )
  (:goal
    (and (despises narrator bill)
    (apologized narrator mom)
    (apologized narrator dad)
    (influenced narrator)
    (isolated narrator)
    (manipulates bill narrator))
  )
)