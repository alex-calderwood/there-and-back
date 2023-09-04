(define (problem life-reflection)
  (:domain
    life-reflection)
  (:objects
    protagonist - character
    sadness joy fury wisdom forgiveness - emotion)
  (:init
    (alive protagonist)
    (intends protagonist (has-emotion protagonist sadness))
    (intends protagonist (has-emotion protagonist joy))
    (intends protagonist (has-emotion protagonist fury))
    (intends protagonist (has-emotion protagonist wisdom))
    (intends protagonist (has-emotion protagonist forgiveness))
    (intends protagonist (knows-change protagonist))
    (intends protagonist (memorize protagonist))
  )
  (:goal
    (and (has-emotion protagonist sadness)
    (has-emotion protagonist joy)
    (has-emotion protagonist fury)
    (has-emotion protagonist wisdom)
    (has-emotion protagonist forgiveness)
    (knows-change protagonist)
    (memorize protagonist))
  )
)