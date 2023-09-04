(define (problem haunted-swing-problem)
  (:domain
    haunted-swing)
  (:objects
    steven irene old-man - character)
  (:init
    (alive steven)
    (intends steven (alive steven))
    (dead irene)
    (murdered irene unknown)
    (alive old-man)
    (intends old-man (pushing-swing old-man))
  )
  (:goal
    (and (dead steven)
    (pushing-swing old-man))
  )
)