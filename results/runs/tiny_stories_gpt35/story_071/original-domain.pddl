(define (domain bird-escape)
  (:requirements :strips :typing :equality)
  (:types bird cat - object)
  (:predicates
    (in-cage ?bird - bird)
    (free ?bird - bird)
    (knows-escape-idea ?cat - cat)
  )

  ;; A bird breaks out of its cage.
  (:action break-out
    :parameters
      (?bird - bird)
    :precondition
      (in-cage ?bird)
    :effect
      (and (not (in-cage ?bird))
      (free ?bird))
  )

  ;; A cat gives an escape idea to a bird.
  (:action give-idea
    :parameters
      (?cat - cat ?bird - bird)
    :precondition
      (and (not (= ?cat ?bird))
      (not (free ?bird))
      (knows-escape-idea ?cat))
    :effect
      (knows-escape-idea ?bird)
  )
)