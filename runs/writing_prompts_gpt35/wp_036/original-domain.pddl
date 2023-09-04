(define (domain light-creator)
  (:requirements :adl :expression-variables :intentionality)
  (:types object - object)
  (:constants
    light - object
    box - object
    mirror - object
  )
  (:predicates
    (anchored ?object - object)
    (in-box ?object - object ?box - object)
    (has-energy ?object - object)
    (has-mirror ?box - object ?mirror - object)
    (has-button ?box - object)
    (open ?box - object)
    (shines ?object - object)
    (causes-fire ?object - object)
    (extinguished ?object - object)
  )

  ;; A character anchors an object in place.
  (:action anchor
    :parameters
      (?character - object ?object - object ?anchor - object)
    :precondition
      (and (not (anchored ?object))
      (at ?object ?anchor)
      (alive ?character))
    :effect
      (anchored ?object)
    :agents
      (?character)
  )

  ;; A character places an object in a box.
  (:action place-in-box
    :parameters
      (?character - object ?object - object ?box - object)
    :precondition
      (and (not (in-box ?object ?box))
      (at ?object ?character)
      (at ?box ?character)
      (alive ?character))
    :effect
      (in-box ?object ?box)
    :agents
      (?character)
  )

  ;; A character puts energy into an object.
  (:action charge
    :parameters
      (?character - object ?object - object)
    :precondition
      (and (not (has-energy ?object))
      (at ?object ?character)
      (alive ?character))
    :effect
      (has-energy ?object)
    :agents
      (?character)
  )

  ;; A character puts a mirror in a box.
  (:action add-mirror
    :parameters
      (?character - object ?box - object ?mirror - object)
    :precondition
      (and (not (has-mirror ?box ?mirror))
      (at ?mirror ?character)
      (at ?box ?character)
      (alive ?character))
    :effect
      (has-mirror ?box ?mirror)
    :agents
      (?character)
  )

  ;; A character adds a button to a box.
  (:action add-button
    :parameters
      (?character - object ?box - object)
    :precondition
      (and (not (has-button ?box))
      (at ?box ?character)
      (alive ?character))
    :effect
      (has-button ?box)
    :agents
      (?character)
  )

  ;; A character opens a box.
  (:action open-box
    :parameters
      (?character - object ?box - object)
    :precondition
      (and (has-button ?box)
      (at ?box ?character)
      (alive ?character))
    :effect
      (open ?box)
    :agents
      (?character)
  )

  ;; A character closes a box.
  (:action close-box
    :parameters
      (?character - object ?box - object)
    :precondition
      (and (open ?box)
      (at ?box ?character)
      (alive ?character))
    :effect
      (not (open ?box))
    :agents
      (?character)
  )

  ;; A character shines a beam of light.
  (:action shine
    :parameters
      (?character - object ?box - object ?mirror - object)
    :precondition
      (and (has-energy light)
      (has-mirror ?box ?mirror)
      (in-box light ?box)
      (open ?box)
      (at ?character ?box)
      (alive ?character))
    :effect
      (and (shines light)
      (not (has-energy light))
      (not (open ?box))
      (not (in-box light ?box))
      (causes-fire light))
    :agents
      (?character)
  )

  ;; A character extinguishes a fire.
  (:action extinguish
    :parameters
      (?character - object ?fire - object)
    :precondition
      (and (causes-fire ?fire)
      (at ?fire ?character)
      (alive ?character))
    :effect
      (extinguished ?fire)
    :agents
      (?character)
  )
)