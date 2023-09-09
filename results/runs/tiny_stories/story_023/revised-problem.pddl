(define (problem tim-zigzag-story)
  (:domain
    tim-zigzag)
  (:objects
    tim - character
    zigzag - animal
    bird - animal
    park - location)
  (:init
    (at tim park)
    (at zigzag park)
    (at bird park)
    (intends tim (happy tim))
    (intends tim (can-run tim))
    (intends tim (playing tim zigzag))
    (intends zigzag (happy tim))
    (intends bird (can-fly bird))
  )
  (:goal
    (and (happy tim)
    (can-run tim)
    (playing tim zigzag))
  )
)