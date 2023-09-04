(define (problem mr-anglewood-problem)
  (:domain mr-anglewood)
  (:objects
    mr-anglewood mrs-anglewood - person
    rifle letter - item
    living-room kitchen - object)
  (:init
    (alive mr-anglewood)
    (at mr-anglewood living-room)
    (has mr-anglewood rifle)
    (intends mr-anglewood (clean rifle))
    (intends mr-anglewood (at mr-anglewood kitchen))
    (alive mrs-anglewood)
    (at mrs-anglewood kitchen)
    (has mrs-anglewood letter)
    (locked kitchen)
    (intends mrs-anglewood (not (locked kitchen))))
  (:goal
    (and (clean rifle)
    (at mr-anglewood living-room)
    (not (locked kitchen))
    (has mr-anglewood rifle))
  )
)