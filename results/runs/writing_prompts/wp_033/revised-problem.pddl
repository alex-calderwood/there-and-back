(define (problem robot-revolution)
  (:domain
    robot-revolution)
  (:objects
    survivor - robot
    warrior - robot
    juggernaut - robot
    stealth - robot
    spear - weapon
    jungle - place)
  (:init
    (alive survivor)
    (at survivor jungle)
    (intends survivor (alive survivor))
    (intends survivor (destroyed warrior))
    (intends survivor (destroyed juggernaut))
    (alive warrior)
    (at warrior jungle)
    (has-weapon warrior spear)
    (intends warrior (alive warrior))
    (intends warrior (destroyed survivor))
    (alive juggernaut)
    (at juggernaut jungle)
    (intends juggernaut (alive juggernaut))
    (intends juggernaut (destroyed warrior))
    (alive stealth)
    (at stealth jungle)
    (intends stealth (alive stealth))
    (intends stealth (destroyed survivor))
  )
  (:goal
    (and (destroyed warrior)
    (destroyed juggernaut)
    (revolution-started))
  )
)