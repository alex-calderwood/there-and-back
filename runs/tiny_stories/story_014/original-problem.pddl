(define (problem park-playtime)
  (:domain
    park-playtime)
  (:objects
    joe paul - character)
  (:init
    (intends joe (happy joe))
    (intends paul (happy paul)))
  (:goal
    (and (happy joe)
    (happy paul)))
)