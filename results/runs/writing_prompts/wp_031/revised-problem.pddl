(define (problem moby-dick-encounter)
  (:domain
    moby-dick)
  (:objects
    captain seaman first-officer - character
    frigate - ship)
  (:init
    (alive captain)
    (on-ship captain frigate)
    (intends captain (alive captain))
    (intends captain (not (moby-dick-attacking frigate)))
    (alive seaman)
    (on-ship seaman frigate)
    (intends seaman (alive seaman))
    (intends seaman (not (moby-dick-attacking frigate)))
    (alive first-officer)
    (on-ship first-officer frigate)
    (intends first-officer (alive first-officer))
    (intends first-officer (not (moby-dick-attacking frigate)))
    (read-moby-dick first-officer)
    (trained-in-whale-killing first-officer))
  (:goal
    (and (not (moby-dick-attacking frigate))
    (battle-stations frigate)))
)