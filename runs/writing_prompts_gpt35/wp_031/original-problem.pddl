(define (problem moby-dick-encounter)
  (:domain moby-dick)
  (:objects
    captain seamen - character
    ship - place)
  (:init
    (alive captain)
    (at captain ship)
    (intends captain (alive captain))
    (intends captain (not (knows-how-to-kill-whale captain)))
    (intends captain (not (has-read-moby-dick captain)))
    (intends captain (not (kill-whale captain)))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (intends captain (travel captain ship ship))
    (int