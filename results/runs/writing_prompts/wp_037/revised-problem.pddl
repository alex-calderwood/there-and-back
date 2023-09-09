(define (problem wally-wilma-wenda)
  (:domain
    wally-and-wilma)
  (:objects
    wally wilma wenda - character)
  (:init
    (knows wally wilma)
    (together wally wilma)
    (missing wilma)
    (intends wally (found wally wilma))
    (intends wally (relationship wally wenda))
    (knows wally wenda)
    (intends wenda (relationship wally wenda))
  )
  (:goal
    (and (found wally wilma)
    (relationship wally wenda))
  )
)