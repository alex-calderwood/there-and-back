(define (problem cecil-and-the-crone)
  (:domain
    cecil-and-the-crone)
  (:objects
    cecil blanche crone - character)
  (:init
    (knows-cooking crone)
    (intends cecil (not (injured cecil)))
    (intends cecil (not (messy cecil)))
    (intends cecil (not (burning cecil)))
    (intends cecil (knows-cooking cecil))
    (intends blanche (not (injured blanche)))
    (intends blanche (not (messy blanche)))
    (intends blanche (not (burning blanche)))
    (intends crone (summoned crone))
  )
  (:goal
    (and (knows-cooking cecil)
    (not (injured cecil))
    (not (messy cecil))
    (not (burning cecil))
    (summoned crone))
  )
)