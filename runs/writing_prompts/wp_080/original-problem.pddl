(define (problem centaur-mines-problem)
  (:domain centaur-mines)
  (:objects
    molly handmaiden goblin - character
    mines waystation - place
    pickaxe - item)
  (:init
    (alive molly)
    (extra-arms molly)
    (at molly mines)
    (intends molly (alive molly))
    (intends molly (extra-arms molly))
    (alive handmaiden)
    (at handmaiden mines)
    (intends handmaiden (alive handmaiden))
    (intends handmaiden (not (extra-arms handmaiden)))
    (alive goblin)
    (at goblin mines)
    (intends goblin (alive goblin))
    (intends goblin (in-revolution handmaiden))
    (has handmaiden pickaxe))
  (:goal
    (and (in-revolution handmaiden)
    (not (extra-arms handmaiden))))
)