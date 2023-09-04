(define (problem chess-sisters-story)
  (:domain
    chess-sisters)
  (:objects
    lucy mia - character)
  (:init
    (intends lucy (play-chess lucy mia))
    (intends mia (play-chess lucy mia))
    (intends mia (sit-together lucy mia))
    (intends lucy (happy lucy))
    (intends mia (happy mia))
    (intends lucy (feel-better lucy))
  )
  (:goal
    (and (happy lucy)
    (happy mia)
    (feel-better lucy)
    (play-chess lucy mia))
  )
)