(define (problem tim-and-bird)
  (:domain
    tim-and-bird)
  (:objects
    tim - character
    tree playground - place
    bird - bird)
  (:init
    (at tim playground)
    (awake tim)
    (intends tim (friend bird tim))
    (intends tim (play tim bird playground))
    (at bird tree)
    (intends bird (friend bird tim))
    (intends bird (land bird tim playground))
    (intends bird (sing bird playground)))
  (:goal
    (and (not (singing bird))
    (not (at bird playground))
    (not (has tim bird)))
  )
)