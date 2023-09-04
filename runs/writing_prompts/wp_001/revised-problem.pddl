(define (problem survive-apocalypse)
  (:domain
    post-apocalyptic-world)
  (:objects
    protagonist - character
    house town - place
    baseball-bat - weapon)
  (:init
    (alive protagonist)
    (at protagonist house)
    (has protagonist baseball-bat)
    (intends protagonist (alive protagonist))
    (intends protagonist (generator-active town))
    (at tv house)
    (on tv))
  (:goal
    (and (at protagonist town)
    (generator-active town)
    (alive protagonist))
  )
)