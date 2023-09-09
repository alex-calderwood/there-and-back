(define (problem bunny-bird-play)
  (:domain
    bunny-bird-friends)
  (:objects
    bob - character
    tim - character
    home - place
    bridge - place)
  (:init
    (at bob home)
    (at tim home)
    (intends bob (happy bob))
    (intends bob (played-together bob tim))
    (intends tim (happy tim))
    (intends tim (played-together bob tim)))
  (:goal
    (and (played-together bob tim)
    (happy bob)
    (happy tim)
    (tired bob)
    (tired tim)
    (at bob home)
    (at tim home))
  )
)