(define (problem ball-in-mailbox)
  (:domain
    ball-mailbox)
  (:objects
    girl bird - character
    ball - item
    mailbox location - place)
  (:init
    (at girl location)
    (at bird location)
    (at mailbox location)
    (not (in-mailbox ball))
    (not (has girl ball))
    (not (has bird ball))
    (happy girl)
    (small bird))
  (:goal
    (and (happy girl)
    (has girl ball)
    (not (in-mailbox ball))))
)