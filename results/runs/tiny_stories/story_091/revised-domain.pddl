(define (domain sun-and-tree)
  (:requirements :adl :domain-axioms :intentionality)
  (:types sun plant animal - object)
  (:predicates
    (awake ?animal - animal)
    (happy ?animal - animal)
    (growing ?plant - plant)
    (strong ?plant - plant)
    (provides-shade ?plant - plant)
    (provides-home ?plant - plant)
    (generous ?sun - sun)
    (gives-heat ?sun - sun)
  )

  ;; The sun wakes up the animals.
  (:action wake-up
    :parameters
      (?sun - sun ?animal - animal)
    :precondition
      (and (generous ?sun)
      (gives-heat ?sun)
      (not (awake ?animal)))
    :effect
      (awake ?animal)
    :agents
      (?sun)
  )

  ;; The sun makes the animals happy.
  (:action make-happy
    :parameters
      (?sun - sun ?animal - animal)
    :precondition
      (and (generous ?sun)
      (gives-heat ?sun)
      (awake ?animal)
      (not (happy ?animal)))
    :effect
      (happy ?animal)
    :agents
      (?sun)
  )

  ;; The sun helps the plant grow.
  (:action help-grow
    :parameters
      (?sun - sun ?plant - plant)
    :precondition
      (and (generous ?sun)
      (gives-heat ?sun)
      (not (growing ?plant)))
    :effect
      (growing ?plant)
    :agents
      (?sun)
  )

  ;; The plant becomes strong.
  (:action become-strong
    :parameters
      (?plant - plant)
    :precondition
      (growing ?plant)
    :effect
      (strong ?plant)
  )

  ;; The plant provides shade and home.
  (:action provide-shade-and-home
    :parameters
      (?plant - plant)
    :precondition
      (strong ?plant)
    :effect
      (and (provides-shade ?plant)
      (provides-home ?plant))
  )

  ;; The sun is generous.
  (:axiom
    :vars
      (?sun - sun)
    :context
      (and (not (generous ?sun))
      (gives-heat ?sun))
    :implies
      (generous ?sun)
  )
)