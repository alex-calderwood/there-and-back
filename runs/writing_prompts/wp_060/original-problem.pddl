(define (problem anglewood-hunt)
  (:domain
    anglewood-hunt)
  (:objects
    mr-anglewood mrs-anglewood - character
    living-room kitchen - place
    rifle uniform door letter - item)
  (:init
    (alive mr-anglewood)
    (at mr-anglewood living-room)
    (has mr-anglewood rifle)
    (has mr-anglewood uniform)
    (intends mr-anglewood (clean rifle))
    (intends mr-anglewood (wearing mr-anglewood uniform))
    (alive mrs-anglewood)
    (at mrs-anglewood kitchen)
    (has mrs-anglewood letter)
    (intends mrs-anglewood (locked door))
    (not (clean rifle))
    (not (fits uniform mr-anglewood))
    (not (locked door)))
  (:goal
    (and (clean rifle)
    (wearing mr-anglewood uniform)
    (locked door))
  )
)