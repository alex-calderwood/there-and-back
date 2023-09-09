(define (problem ant-and-bird-problem)
  (:domain ant-and-bird)
  (:objects
    ant1 bird1 apple1 - object)
  (:init
    (at ant1 apple1)
    (at bird1 apple1)
    (intends ant1 (holding ant1 apple1))
    (intends ant1 (eating ant1 apple1))
    (intends bird1 (hitting bird1 apple1))
    (intends bird1 (helping ant1))
  )
  (:goal
    (and (not (holding ant1 apple1))
    (not (broken apple1))))
)