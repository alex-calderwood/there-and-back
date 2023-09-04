(define (problem space-fart-discovery)
  (:domain
    space-fart-technology)
  (:objects
    qlorog qlala qlaaf qllalee - character
    ancient-ship - object
    illar-4-sector qqlchar-base-1 - place)
  (:init
    (at qlorog illar-4-sector)
    (at qlala illar-4-sector)
    (at qlaaf illar-4-sector)
    (at qllalee illar-4-sector)
    (alive qlorog)
    (alive qlala)
    (alive qlaaf)
    (alive qllalee)
    (intends qlorog (alive qlorog))
    (intends qlala (alive qlala))
    (intends qlaaf (alive qlaaf))
    (intends qllalee (alive qllalee))
  )
  (:goal
    (and (at qlorog qqlchar-base-1)
    (not (has qlorog ancient-ship))
    (requested-tow qlala qqlchar-base-1)))
)