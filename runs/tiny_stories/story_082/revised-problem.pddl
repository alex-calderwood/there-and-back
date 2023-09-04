(define (problem tim-and-bird-story)
  (:domain
    tim-and-bird)
  (:objects
    tim bird - character
    school playground tree - place)
  (:init
    (at tim school)
    (awake tim)
    (intends tim (at tim tree))
    (intends tim (not (awake tim)))
    (intends tim (awake tim))
    (intends tim (friends tim bird))
    (intends tim (playing tim bird))
    (at bird tree)
    (awake bird)
    (intends bird (on-head bird tim))
    (intends bird (singing bird))
    (intends bird (friends bird tim))
    (intends bird (playing bird tim))
    (intends bird (at bird playground))
    (intends tim (at tim playground)))
  (:goal
    (and (friends tim bird)
    (playing tim bird))
  )
)