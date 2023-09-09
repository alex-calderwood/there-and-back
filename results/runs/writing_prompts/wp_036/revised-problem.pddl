(define (problem light-power-story)
  (:domain
    light-power)
  (:objects
    protagonist - character
    lightbox1 lightbox2 lightbox3 - lightbox)
  (:init
    (alive protagonist)
    (intends protagonist (used protagonist lightbox1))
    (intends protagonist (used protagonist lightbox2))
    (intends protagonist (used protagonist lightbox3)))
  (:goal
    (and (used protagonist lightbox1)
    (used protagonist lightbox2)
    (used protagonist lightbox3)))
)