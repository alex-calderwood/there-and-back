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

<|Solution|>

(define (plan park-playtime-solution)
  (:problem park-playtime)
  (:steps (go-to-park paul)
          (get-on-swing paul)
          (start-swinging paul)
          (get-off-swing paul)
          (go-to-park joe)
          (get-on-swing joe)
          (start-swinging joe)
          (get-off-swing joe)))