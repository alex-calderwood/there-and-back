(define (problem bill-clinton-death)
  (:domain
    bill-clinton)
  (:objects
    bill william-jefferson john-james-smith death - character
    arkansas - place)
  (:init
    (alive bill)
    (at bill arkansas)
    (is-bill bill)
    (intends bill (alive bill))
    (alive william-jefferson)
    (at william-jefferson arkansas)
    (is-william-jefferson william-jefferson)
    (intends william-jefferson (alive william-jefferson))
    (alive john-james-smith)
    (at john-james-smith arkansas)
    (is-john-james-smith john-james-smith)
    (intends john-james-smith (alive john-james-smith))
    (alive death)
    (at death arkansas)
    (intends death (not (alive william-jefferson)))
  )
  (:goal
    (and (alive bill)
    (not (alive william-jefferson))
    (alive john-james-smith))
  )
)