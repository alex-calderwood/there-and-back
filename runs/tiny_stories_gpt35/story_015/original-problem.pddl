(define (problem dog-race-problem)
  (:domain dog-race)
  (:objects
    sam ben - dog
    ball block - toy
    yard - object)
  (:init
    (at sam yard)
    (at ben yard)
    (stacked ball)
    (stacked block)
    (intends sam (holding sam ball))
    (intends ben (holding ben block))
    (intends sam (racing ben))
    (intends ben (racing ben))
    (intends sam (won ben))
    (intends ben (not (holding ben block)))
    (intends sam (not (holding sam ball))))
  (:goal
    (and (won ben)
    (stacked ball)
    (stacked block)))
)