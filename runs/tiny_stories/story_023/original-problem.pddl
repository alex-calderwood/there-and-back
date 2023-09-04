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
    (intends zigzag (happy tim))
    (intends bird (can-fly bird))
  )
  (:goal
    (and (happy tim)
    (can-run tim)
    (playing tim zigzag))
  )
)