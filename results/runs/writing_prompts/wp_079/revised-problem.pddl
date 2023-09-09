(define (problem richard-rahl-life)
  (:domain
    richard-rahl)
  (:objects
    richard wife friend - character
    westland aydindril new-world - place)
  (:init
    (at richard aydindril)
    (ruler richard new-world)
    (supporter wife richard new-world)
    (supporter friend richard new-world)
    (united new-world)
    (at wife aydindril)
    (at friend aydindril)
    (intends richard (happy richard))
    (intends richard (united new-world))
    (intends wife (happy richard))
    (intends friend (happy richard))
  )
  (:goal
    (and (happy richard)
    (united new-world))
  )
)