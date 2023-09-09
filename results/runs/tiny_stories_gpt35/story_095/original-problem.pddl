(define (problem cat-and-dog-problem)
  (:domain cat-and-dog)
  (:objects
    tom - cat
    fido - dog
    big-seat small-seat tree - object
    big-ball - ball)
  (:init
    (at tom tree)
    (at fido big-seat)
    (at big-ball big-seat)
    (intends tom (at tom small-seat))
    (intends fido (sitting fido big-seat))
    (intends fido (not (sitting fido small-seat))))
  (:goal
    (and (sitting fido small-seat)
    (not (sitting fido big-seat))
    (not (broken big-seat))))