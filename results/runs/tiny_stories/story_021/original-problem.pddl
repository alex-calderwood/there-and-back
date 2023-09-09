(define (problem lucy-cooking-and-playing)
  (:domain
    lucy-cooking-and-playing)
  (:objects
    lucy mom - character)
  (:init
    (wants-to-cook lucy)
    (intends lucy (cooking lucy))
    (intends lucy (playing-with-band lucy))
    (wants-to-play-with-band lucy))
  (:goal
    (and (cooking lucy)
    (playing-with-band lucy))
  )
)