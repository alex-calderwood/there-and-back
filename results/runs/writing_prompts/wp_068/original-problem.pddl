(define (problem dream-battle)
  (:domain
    dream-world)
  (:objects
    protagonist chalcedon - character
    home coffee-shop - place
    armor sword - item)
  (:init
    (alive protagonist)
    (awake protagonist)
    (at protagonist home)
    (intends protagonist (alive protagonist))
    (alive chalcedon)
    (at chalcedon coffee-shop)
    (has chalcedon armor)
    (has chalcedon sword)
    (wearing chalcedon armor)
    (intends chalcedon (not (alive protagonist))))
  (:goal
    (and (alive protagonist)
    (not (alive chalcedon))))
)