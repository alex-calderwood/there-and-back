(define (problem werewolf-transformation)
  (:domain
    werewolf-runner)
  (:objects
    runner - character
    start middle end - place)
  (:init
    (at runner start)
    (awake runner)
    (werewolf runner)
    (full-moon))
  (:goal
    (and (transformed runner)
    (at runner end)))
)