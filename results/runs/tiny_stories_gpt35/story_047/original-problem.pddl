(define (problem zara-and-momo-play)
  (:domain zara-and-momo)
  (:objects
    zara momo - character
    ball - toy)
  (:init
    (has zara ball)
    (has momo ball)
    (intends zara (playing zara ball))
    (intends momo (playing momo ball)))
  (:goal
    (and (playing zara ball)
    (playing momo ball)))
)