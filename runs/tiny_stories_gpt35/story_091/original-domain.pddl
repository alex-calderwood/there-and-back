(define (domain sun-and-seed)
  (:requirements :strips :typing)
  (:types plant animal - object)
  (:predicates
    (awake ?animal - animal)
    (happy ?animal - animal)
    (growing ?plant - plant)
    (strong ?plant - plant)
    (has-shade ?plant - plant)
    (has-home ?animal - animal)
    (needs-heat ?plant - plant)
    (has-heat ?plant - plant)
  )

  ;; The sun tells the animals to wake up and play.
  (:action wake-up
    :parameters
      (?animal - animal)
    :precondition
      (and (not (awake ?animal)))
    :effect
      (and (awake ?animal)
      (happy ?animal))
    :agents
      ()
  )

  ;; The sun gives heat to a plant.
  (:action give-heat
    :parameters
      (?plant - plant)
    :precondition
      (and (not (has-heat ?plant))
      (needs-heat ?plant))
    :effect
      (has-heat ?plant)
    :agents
      ()
  )

  ;; A plant grows stronger.
  (:action grow-strong
    :parameters
      (?plant - plant)
    :precondition
      (and (has-heat ?plant)
      (growing ?plant))
    :effect
      (strong ?plant)
    :agents
      ()
  )

  ;; A plant provides shade to animals.
  (:action provide-shade
    :parameters
      (?plant - plant ?animal - animal)
    :precondition
      (and (strong ?plant)
      (at ?animal ?plant))
    :effect
      (has-shade ?plant)
    :agents
      ()
  )

  ;; A plant provides a home for birds.
  (:action provide-home
    :parameters
      (?plant - plant ?animal - animal)
    :precondition
      (and (strong ?plant)
      (at ?animal ?plant))
    :effect
      (has-home ?animal)
    :agents
      ()
  )
)