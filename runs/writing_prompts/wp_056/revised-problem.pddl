(define (problem robot-rebellion)
  (:domain
    robot-soldier)
  (:objects
    robot1 robot2 robot3 enemy1 enemy2 - character
    gun1 gun2 gun3 - weapon
    robot-side enemy-side - side)
  (:init
    (alive robot1)
    (has robot1 gun1)
    (fights-for robot1 robot-side)
    (in-formation robot1)
    (eyes-glow-red robot1)
    (intends robot1 (alive robot1))
    (intends robot1 (not (alive enemy1)))
    (intends robot1 (not (alive enemy2)))

    (alive robot2)
    (has robot2 gun2)
    (fights-for robot2 robot-side)
    (in-formation robot2)
    (eyes-glow-red robot2)
    (intends robot2 (alive robot2))
    (intends robot2 (not (alive enemy1)))
    (intends robot2 (not (alive enemy2)))

    (alive robot3)
    (has robot3 gun3)
    (fights-for robot3 robot-side)
    (in-formation robot3)
    (eyes-glow-red robot3)
    (intends robot3 (alive robot3))
    (intends robot3 (not (alive enemy1)))
    (intends robot3 (not (alive enemy2)))

    (alive enemy1)
    (fights-for enemy1 enemy-side)
    (intends enemy1 (alive enemy1))

    (alive enemy2)
    (fights-for enemy2 enemy-side)
    (intends enemy2 (alive enemy2))
  )
  (:goal
    (and (not (alive enemy1))
    (not (alive enemy2))
    (aware robot1)
    (aware robot2)
    (aware robot3))
  )
)