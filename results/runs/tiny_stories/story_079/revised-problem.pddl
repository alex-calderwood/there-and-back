(define (problem tim-and-puppy-adventure)
  (:domain
    tim-and-puppy)
  (:objects
    tim puppy - character
    home park - place
    ball - object)
  (:init
    (at tim home)
    (tired tim)
    (intends tim (happy tim))
    (intends tim (not (tired tim)))
    (intends tim (playing-together tim puppy))
    (intends tim (at tim home))
    (intends tim (at puppy home))
    (at puppy park)
    (tired puppy)
    (intends puppy (happy puppy))
    (intends puppy (not (tired puppy)))
    (intends puppy (playing-together tim puppy))
    (intends puppy (at tim home))
    (intends puppy (at puppy home))
    (at ball park))
  (:goal
    (and (happy tim)
    (not (tired tim))
    (happy puppy)
    (not (tired puppy))
    (playing-together tim puppy)
    (at tim home)
    (at puppy home))
  )
)