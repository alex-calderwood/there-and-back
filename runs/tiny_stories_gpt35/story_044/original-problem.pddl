(define (problem ball-in-mailbox)
  (:domain ball-rescue)
  (:objects
    ball mailbox - object
    girl bird - bird)
  (:init
    (at ball mailbox)
    (in-mailbox ball)
    (at girl mailbox)
    (intends girl (not (in-mailbox ball)))
    (intends girl (holding girl ball))
    (intends bird (holding bird ball))
    (intends bird (not (in-mailbox ball)))
    (intends bird (not (at ball mailbox)))
  )
  (:goal
    (and (at ball girl)
    (not (in-mailbox ball)))
  )
)