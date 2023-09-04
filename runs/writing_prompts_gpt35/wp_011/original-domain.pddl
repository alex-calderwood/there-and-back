(define (domain space-fart-machines)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object lifeform - character device - item)
  (:constants qqlchar-base-1 - place)
  (:predicates
    (in-stasis ?lifeform - lifeform)
    (fragile ?lifeform - lifeform)
    (shielded ?lifeform - lifeform)
    (has ?character - character ?device - device)
    (at ?character - character ?place - place)
    (intends ?character - character ?predicate - predicate)
    (towed ?device - device)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - place ?to - place)
    :precondition
      (and (not (= ?from ?to))
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; A character excavates an item.
  (:action detect
    :parameters
      (?character - character ?device - device)
    :precondition
      (and (at ?character qqlchar-base-1)
      (towed ?device))
    :effect
      (and (not (towed ?device))
      (at ?device ?character))
    :agents  (?character)
  )

  ;; One character gives an item to another.
  (:action tow
    :parameters
      (?tow-er - character ?device - device ?tow-ee - character ?place - place)
    :precondition
      (and (not (= ?tow-er ?tow-ee))
      (at ?tow-er ?place)
      (has ?tow-er ?device)
      (at ?tow-ee ?place))
    :effect
      (and (not (at ?tow-er ?device))
      (towed ?device))
    :agents
      (?tow-er)
  )

  ;; A character wakes up a lifeform from stasis.
  (:action wake-up
    :parameters
      (?character - character ?lifeform - lifeform)
    :precondition
      (and (at ?character qqlchar-base-1)
      (in-stasis ?lifeform)
      (not (fragile ?lifeform))
      (not (shielded ?lifeform)))
    :effect
      (and (not (in-stasis ?lifeform))
      (intends ?lifeform (alive ?lifeform)))
    :agents
      (?character)
  )

  ;; A character tows a device to a location.
  (:action tow-in
    :parameters
      (?character - character ?device - device ?location - place)
    :precondition
      (and (at ?character qqlchar-base-1)
      (towed ?device))
    :effect
      (and (not (towed ?device))
      (at ?device ?location))
    :agents
      (?character)
  )
)