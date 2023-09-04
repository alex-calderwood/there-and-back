(define (problem human-chop-shop)
  (:domain
    human-chop-shop)
  (:objects
    protagonist partner owner - character
    warehouse office basement - place
    keys - key)
  (:init
    (alive protagonist)
    (intends protagonist (alive protagonist))
    (intends protagonist (knows-location protagonist basement))
    (alive partner)
    (intends partner (alive partner))
    (intends partner (knows-location partner basement))
    (alive owner)
    (intends owner (alive owner))
    (at protagonist office)
    (at partner office)
    (at owner office)
    (at warehouse office)
    (at basement warehouse)
    (locked basement)
    (matches keys basement)
    (has owner keys))
  (:goal
    (and (knows-location protagonist basement)
    (knows-location partner basement)
    (not (alive protagonist))
    (not (alive partner))))
)