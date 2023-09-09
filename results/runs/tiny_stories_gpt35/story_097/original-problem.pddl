(define (problem animal-friends-problem)
  (:domain animal-friends)
  (:objects
    billy henry - animal)
  (:init
    (friend billy henry)
    (friend henry billy)
    (not (sad henry))
    (intends billy (friend billy henry))
    (intends henry (friend henry billy))
    (intends billy (practice billy henry))
    (intends henry (practice henry billy))
    (intends billy (pull billy))
    (intends henry (pull henry)))
  (:goal
    (and (pulling henry)
    (pulling billy)))
)