(define (problem zombie-survival)
  (:domain zombie-apocalypse)
  (:objects
    protagonist - character
    girlfriend - character
    chair toilet - object
    hardware-store driveway - object
    plunger - object
    hardware-store - location
    house - location
    book - item
    magazine - item
    board-game - item
    food - item
    electricity - item
    zombie1 zombie2 zombie3 - character
    )
  (:init
    (alive protagonist)
    (at protagonist house)
    (intends protagonist (