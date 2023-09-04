(define (problem friendship-story)
  (:domain
    friendship)
  (:objects
    protagonist frederick - character
    unfamiliar-place fredericks-place bright-place - place
    delicious-food - food)
  (:init
    (at protagonist unfamiliar-place)
    (at frederick unfamiliar-place)
    (alive protagonist)
    (alive frederick)
    (has-name frederick)
    (eats protagonist delicious-food)
    (has-balls protagonist)
    (intends protagonist (at protagonist fredericks-place))
    (intends protagonist (comfortable protagonist))
    (intends protagonist (not (trusts protagonist frederick)))
    (intends protagonist (not (has-balls protagonist)))
    (intends protagonist (scratches-ears frederick protagonist))
    (intends frederick (scratches-ears frederick protagonist))
  )
  (:goal
    (and (at protagonist fredericks-place)
    (comfortable protagonist)
    (not (trusts protagonist frederick))
    (not (has-balls protagonist))
    (scratches-ears frederick protagonist))
  )
)