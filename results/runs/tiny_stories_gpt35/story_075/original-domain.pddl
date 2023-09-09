(define (domain little-girl-dress)
  (:requirements :strips :typing :equality :quantified-preconditions :expression-variables)
  (:types dress - item girl - character)
  (:constants pink-roses red-yellow-flowers - dress)
  (:predicates
    (wearing ?girl - girl ?dress - dress)
    (has ?girl - girl ?dress - dress)
    (hole ?dress - dress)
    (comfy ?dress - dress)
    (smart ?girl - girl)
  )

  ;; A girl puts on a dress.
  (:action put-on
    :parameters
      (?girl - girl ?dress - dress)
    :precondition
      (and (not (wearing ?girl ?dress))
      (has ?girl ?dress))
    :effect
      (and (wearing ?girl ?dress)
      (not (has ?girl ?dress)))
    :agents
      (?girl)
  )

  ;; A girl takes off a dress.
  (:action take-off
    :parameters
      (?girl - girl ?dress - dress)
    :precondition
      (wearing ?girl ?dress)
    :effect
      (and (not (wearing ?girl ?dress))
      (has ?girl ?dress))
    :agents
      (?girl)
  )

  ;; A girl goes to the shop to buy a new dress.
  (:action go-to-shop
    :parameters
      (?girl - girl)
    :precondition
      (smart ?girl)
    :effect
      (and (not (smart ?girl))
      (intends ?girl (has ?girl pink-roses)))
    :agents
      (?girl)
  )

  ;; A girl buys a new dress.
  (:action buy-dress
    :parameters
      (?girl - girl ?dress - dress)
    :precondition
      (and (intends ?girl (has ?girl ?dress))
      (not (has ?girl ?dress)))
    :effect
      (and (has ?girl ?dress)
      (intends ?girl (wearing ?girl ?dress)))
    :agents
      (?girl)
  )

  ;; A girl slips and falls.
  (:action slip-and-fall
    :parameters
      (?girl - girl ?dress - dress)
    :precondition
      (and (wearing ?girl ?dress)
      (comfy ?dress))
    :effect
      (and (not (comfy ?dress))
      (hole ?dress)
      (not (smart ?girl)))
    :agents
      (?girl)
  )

  ;; A girl's mum comforts her.
  (:action comfort
    :parameters
      (?girl - girl)
    :precondition
      (not (smart ?girl))
    :effect
      (and (smart ?girl)
      (intends ?girl (has ?girl pink-roses)))
    :agents
      (?girl)
  )
)