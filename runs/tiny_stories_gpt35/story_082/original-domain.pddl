(define (domain tim-and-bird)
  (:requirements :strips :typing :equality :negative-preconditions :existential-preconditions :universal-preconditions :quantified-preconditions :conditional-effects :intentionality)
  (:types character - object bird - character place - object)
  (:predicates
    (at ?character - character ?place - place)
    (asleep ?character - character)
    (awake ?character - character)
    (has ?character - character ?object - object)
    (friend ?character - character ?character - character)
    (singing ?bird - bird)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from)
      (awake ?character))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character takes a nap.
  (:action nap
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (awake ?character))
    :effect
      (and (not (awake ?character))
      (asleep ?character))
    :agents  (?character)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (at ?character ?place)
      (asleep ?character))
    :effect
      (and (not (asleep ?character))
      (awake ?character))
    :agents  (?character)
  )

  ;; A bird lands on a character's head.
  (:action land
    :parameters
      (?bird - bird ?character - character ?place - place)
    :precondition
      (and (at ?bird ?place)
      (at ?character ?place)
      (awake ?character))
    :effect
      (and (not (at ?bird ?place))
      (not (singing ?bird))
      (friend ?bird ?character)
      (has ?character ?bird))
    :agents  (?bird)
  )

  ;; A bird sings a sweet song.
  (:action sing
    :parameters
      (?bird - bird ?place - place)
    :precondition
      (and (at ?bird ?place)
      (friend ?bird ?character)
      (awake ?character))
    :effect
      (singing ?bird)
    :agents  (?bird)
  )

  ;; A character plays with a bird.
  (:action play
    :parameters
      (?character - character ?bird - bird ?place - place)
    :precondition
      (and (at ?character ?place)
      (at ?bird ?place)
      (friend ?bird ?character)
      (awake ?character)
      (singing ?bird))
    :effect
      (and (not (singing ?bird))
      (not (at ?bird ?place))
      (not (has ?character ?bird)))
    :agents  (?character)
  )
)