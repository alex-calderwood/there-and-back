(define (domain neverland)
  (:requirements :strips :negative-preconditions :typing :equality :quantified-preconditions :existential-preconditions :universal-preconditions :conditional-effects :intentionality)
  (:types character - object fairy - character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (alive ?character - character)
    (has ?character - character ?fairy - fairy)
    (believes ?character - character)
    (fighting ?character - character ?opponent - character)
    (in-love ?character - character ?other - character)
    (bored ?character - character)
    (intends ?character - character ?goal - expression)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character fights another character.
  (:action fight
    :parameters
      (?fighter - character ?opponent - character ?place - place)
    :precondition
      (and (alive ?fighter)
      (alive ?opponent)
      (at ?fighter ?place)
      (at ?opponent ?place)
      (not (= ?fighter ?opponent)))
    :effect
      (and (fighting ?fighter ?opponent)
      (fighting ?opponent ?fighter))
    :agents
      (?fighter ?opponent)
  )

  ;; A character stops fighting another character.
  (:action stop-fighting
    :parameters
      (?fighter - character ?opponent - character ?place - place)
    :precondition
      (and (fighting ?fighter ?opponent)
      (fighting ?opponent ?fighter)
      (at ?fighter ?place)
      (at ?opponent ?place))
    :effect
      (and (not (fighting ?fighter ?opponent))
      (not (fighting ?opponent ?fighter)))
    :agents
      (?fighter ?opponent)
  )

  ;; A character falls in love with another character.
  (:action fall-in-love
    :parameters
      (?lover - character ?other - character)
    :precondition
      (and (alive ?lover)
      (alive ?other)
      (not (= ?lover ?other)))
    :effect
      (and (in-love ?lover ?other)
      (in-love ?other ?lover))
    :agents
      (?lover ?other)
  )

  ;; A character stops being in love with another character.
  (:action stop-being-in-love
    :parameters
      (?lover - character ?other - character)
    :precondition
      (and (in-love ?lover ?other)
      (in-love ?other ?lover))
    :effect
      (and (not (in-love ?lover ?other))
      (not (in-love ?other ?lover)))
    :agents
      (?lover ?other)
  )

  ;; A character gets bored.
  (:action get-bored
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (bored ?character)
    :agents
      (?character)
  )

  ;; A character believes in fairies.
  (:action believe-in-fairies
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (believes ?character)
    :agents
      (?character)
  )

  ;; A character intends to do something.
  (:action intend
    :parameters
      (?character - character ?goal - expression)
    :precondition
      (alive ?character)
    :effect
      (intends ?character ?goal)
    :agents
      (?character)
  )

  ;; A fairy leaves a character.
  (:action leave
    :parameters
      (?fairy - fairy ?character - character)
    :precondition
      (and (alive ?fairy)
      (has ?character ?fairy))
    :effect
      (not (has ?character ?fairy))
    :agents
      (?fairy ?character)
  )
)