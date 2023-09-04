(define (problem master-baggins)
  (:domain
    planet-arda)
  (:objects
    protagonist gandalf - character
    spaceship grassy-knoll - place
    oxygen-helmet mithril-vest brown-vest orange-shorts pipe - item
    cart - object)
  (:init
    (at protagonist spaceship)
    (at gandalf grassy-knoll)
    (alive protagonist)
    (alive gandalf)
    (wearing protagonist oxygen-helmet)
    (wearing gandalf mithril-vest)
    (has protagonist cart)
    (has protagonist pipe)
    (has protagonist brown-vest)
    (has protagonist orange-shorts)
    (breathable grassy-knoll)
    (intends protagonist (alive protagonist))
    (intends protagonist (at protagonist grassy-knoll))
    (intends protagonist (has protagonist cart))
    (intends gandalf (alive gandalf))
    (intends gandalf (smoking gandalf))
    (intends gandalf (dancing protagonist))
    (intends gandalf (eating protagonist))
  )
  (:goal
    (and (at protagonist grassy-knoll)
    (shrunk protagonist)
    (wearing protagonist brown-vest)
    (wearing protagonist orange-shorts)
    (dancing protagonist)
    (eating protagonist))
  )
)