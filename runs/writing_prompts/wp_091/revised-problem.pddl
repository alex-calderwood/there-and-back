(define (problem recover-from-breakup)
  (:domain
    breakup-recovery)
  (:objects
    self - character)
  (:init
    (feels-awful self)
    (thinks-about-breakup self)
    (heartbroken self)
    (intends self (forgiven self))
    (intends self (learned self))
    (intends self (moved-on self)))
  (:goal
    (and (forgiven self)
    (learned self)
    (moved-on self))
  )
)

<|Solution|>

(define (plan recover-from-breakup-solution)
  (:problem recover-from-breakup)
  (:steps (learn self)
          (forgive self)
          (move-on self)))