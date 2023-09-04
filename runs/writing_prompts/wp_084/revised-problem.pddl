(define (problem love-confession-problem)
  (:domain
    love-confession)
  (:objects
    protagonist love-interest - character)
  (:init
    (intends protagonist (confessed protagonist love-interest))
    (intends protagonist (loves protagonist love-interest))
    (intends love-interest (asked-question love-interest protagonist))
  )
  (:goal
    (and (confessed protagonist love-interest)
    (loves protagonist love-interest))
  )
)

<|Solution|>

(define (plan love-confession-problem-solution)
  (:problem love-confession-problem)
  (:steps (ask-love-question love-interest protagonist)
          (take-pill protagonist)
          (confess-love protagonist love-interest)))