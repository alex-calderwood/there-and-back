(define (problem magic-bird-wish)
  (:domain
    magic-bird)
  (:objects
    lucy mother bird - character
    park tree - object
    snack special-wish - object)
  (:init
    (at lucy park)
    (at mother park)
    (at tree park)
    (at bird park)
    (has lucy snack)
    (intends lucy (happy lucy))
    (intends mother (happy mother))
    (intends lucy (granted-wish special-wish))
    (intends mother (granted-wish special-wish)))
  (:goal
    (and (happy lucy)
    (happy mother)
    (granted-wish special-wish))
  )
)

<|Solution|>

(define (plan magic-bird-wish-solution)
  (:problem magic-bird-wish)
  (:steps (sit-down mother)
          (sit-down lucy)
          (become-magic lucy)
          (grant-wish lucy special-wish)))