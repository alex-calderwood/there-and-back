(define (problem garden-playtime)
  (:domain garden)
  (:objects
    garden grass flowers trees - physical-object
    cat bird - animal)
  (:init
    (on bird trees)
    (on cat grass)
    (intends cat (asleep cat))
    (intends bird (friend cat))
    (intends bird (playing bird)))
  (:goal
    (and (playing cat)
    (playing bird)
    (friend cat bird)))
)