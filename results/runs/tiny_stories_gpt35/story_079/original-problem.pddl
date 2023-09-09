(define (problem tim-and-puppy)
  (:domain
    tim-and-puppy)
  (:objects
    tim puppy - animal
    ball park home - object)
  (:init
    (at tim park)
    (tired tim)
    (at ball park)
    (asleep puppy)
    (at puppy ball)
    (intends tim (happy tim))
    (intends tim (not (tired tim)))
    (intends puppy (awake puppy))
    (intends tim (become-friends tim puppy))
    (intends tim (travel tim park home))
    (intends puppy (travel puppy park home))
  )
  (:goal
    (and (at tim home)
    (at puppy home)
    (happy tim))
  )
)