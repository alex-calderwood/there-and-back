(define (problem bella-escape)
  (:domain
    bella-escape)
  (:objects
    bella - character
    tom - character
    small-cage - cage)
  (:init
    (in-cage bella small-cage)
    (intends bella (free bella))
    (intends tom (free bella))
    (intends bella (friends bella tom))
    (intends tom (friends bella tom)))
  (:goal
    (and (free bella)
    (friends bella tom)))
)