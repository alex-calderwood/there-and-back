(define (problem tamara-in-amphitheatre)
  (:domain deserted-amphitheatre)
  (:objects
    tamara - character
    mojito bellybutton-bracelet - object
    stage vomit-stain - object)
  (:init
    (alive tamara)
    (at tamara nowhere)
    (intends tamara (fall tamara stage))
    (intends tamara (vomit tamara vomit-stain))
    (intends tamara (belch tamara))
    (intends tamara (wear tamara bellybutton-bracelet))
    (intends tamara (fade tamara bellybutton-bracelet))
    (intends tamara (drink tamara))
  )
  (:goal
    (and (not (alive tamara))
    (at tamara vomit-stain)
    (not (has tamara bellybutton-bracelet))
    (not (at tamara stage)))
  )
)