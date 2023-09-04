(define (problem fairy-helps-pins)
  (:domain
    fairy-and-pins)
  (:objects
    fairy-girl - character
    box - box
    pin1 pin2 pin3 - pin)
  (:init
    (tidy box)
    (in pin1 box)
    (in pin2 box)
    (in pin3 box)
    (at fairy-girl box)
    (fairy fairy-girl))
  (:goal
    (and (forall (?pin - pin)
           (and (in ?pin box)
           (alive ?pin)
           (intends fairy-girl (alive ?pin)))))
  )
)