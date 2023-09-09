(define (problem vasily-wolf-hunter)
  (:domain
    vasily-wolf-hunter)
  (:objects
    vasily - character
    town - place
    rifle ak47 pistol knife - item)
  (:init
    (alive vasily)
    (at vasily town)
    (has vasily rifle)
    (has vasily ak47)
    (has vasily pistol)
    (has vasily knife)
    (wolves-attack town)
    (intends vasily (alive vasily))
    (intends vasily (wolves-killed vasily))
  )
  (:goal
    (and (not (alive vasily))
    (wolves-killed vasily))
  )
)