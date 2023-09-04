(define (problem richard-rahl)
  (:domain
    sword-of-truth)
  (:objects
    richard kahlan - character
    aydindril westland - place)
  (:init
    (alive richard)
    (at richard aydindril)
    (intends richard (ruling aydindril))
    (intends richard (trusts richard kahlan))
    (intends richard (make-happy richard kahlan))
    (intends richard (quell-discontent aydindril))
    (married richard kahlan)
    (alive kahlan)
    (at kahlan aydindril)
    (intends kahlan (alive kahlan))
    (intends kahlan (make-happy kahlan richard))
    (intends kahlan (trusts kahlan richard))
    (intends kahlan (quell-discontent aydindril))
    (not (discontent richard))
    (not (discontent aydindril))
  )
  (:goal
    (and (ruling aydindril)
    (happy richard)
    (happy kahlan))
  )
)