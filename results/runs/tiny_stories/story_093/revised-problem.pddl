(define (problem mop-story)
  (:domain
    mop-selection)
  (:objects
    sue mom dog - character
    store home - place
    old-mop pink-mop blue-mop dog-mop - mop)
  (:init
    (at sue home)
    (at mom home)
    (at dog store)
    (has dog dog-mop)
    (clean dog-mop)
    (pretty dog-mop)
    (disgusting old-mop))
  (:goal
    (and (selected dog-mop)
    (not (selected pink-mop))
    (not (selected blue-mop))))
)