(define (problem alien-liberation-story)
  (:domain
    alien-liberation)
  (:objects
    alien protagonist - character)
  (:init
    (alien-exists alien)
    (intends alien (liberated protagonist))
    (intends alien (defeated-illuminati))
    (intends alien (alien-gone alien))
  )
  (:goal
    (and (liberated protagonist)
    (defeated-illuminati)
    (alien-gone alien))
  )
)

<|Solution|>

(define (plan alien-liberation-story-solution)
  (:problem alien-liberation-story)
  (:steps (defeat-illuminati alien)
          (liberate alien protagonist)
          (disappear alien)))