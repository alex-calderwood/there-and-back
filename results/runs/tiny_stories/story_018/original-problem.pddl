(define (problem daisy-finds-treasure)
  (:domain
    daisy-treasure)
  (:objects
    daisy - character
    bedroom toys-cupboard - place
    treasure-chest - item
    shiny-coins - item)
  (:init
    (at daisy bedroom)
    (hidden treasure-chest bedroom)
    (hidden shiny-coins treasure-chest)
    (intends daisy (found daisy treasure-chest))
    (intends daisy (found daisy shiny-coins))
    (intends daisy (stored shiny-coins toys-cupboard)))
  (:goal
    (and (found daisy treasure-chest)
         (found daisy shiny-coins)
         (stored shiny-coins toys-cupboard)))
)