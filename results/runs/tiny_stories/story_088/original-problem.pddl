(define (problem curious-boy-egg)
  (:domain
    curious-boy-egg)
  (:objects
    boy mom - character
    park - place
    tree - object
    egg - item)
  (:init
    (alive boy)
    (at boy park)
    (intends boy (found boy egg))
    (intends boy (walking-around boy tree))
    (intends boy (pointing boy tree))
    (alive mom)
    (at mom park)
    (intends mom (found mom egg))
    (on-ground egg)
    (at tree park))
  (:goal
    (and (found boy egg)
    (found mom egg)
    (walking-around boy tree)
    (pointing boy tree)))
)