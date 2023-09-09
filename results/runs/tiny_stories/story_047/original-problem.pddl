(define (problem sharing-fun)
  (:domain
    sharing-forest)
  (:objects
    zara momo - character
    red-ball - toy)
  (:init
    (intends zara (happy zara))
    (intends zara (happy momo))
    (intends momo (happy momo))
    (intends momo (happy zara)))
  (:goal
    (and (happy zara)
    (happy momo)
    (playing-together zara momo red-ball)))
)