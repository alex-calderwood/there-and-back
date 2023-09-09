(define (domain internet-outage)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character place - object device - item)
  (:predicates
    (awake ?character - character)
    (wearing-clothes ?character - character)
    (has-device ?character - character ?device - device)
    (device-on ?device - device)
    (device-connected ?device - device)
    (electricity ?place - place)
    (at ?character - character ?place - place)
    (working ?device - device)
    (school-canceled)
  )

  ;; A character wakes up.
  (:action wake-up
    :parameters
      (?character - character)
    :precondition
      (not (awake ?character))
    :effect
      (awake ?character)
    :agents
      (?character)
  )

  ;; A character puts on clothes.
  (:action put-on-clothes
    :parameters
      (?character - character)
    :precondition
      (and (awake ?character)
      (not (wearing-clothes ?character)))
    :effect
      (wearing-clothes ?character)
    :agents
      (?character)
  )

  ;; A character turns on a device.
  (:action turn-on-device
    :parameters
      (?character - character ?device - device)
    :precondition
      (and (awake ?character)
      (has-device ?character ?device)
      (not (device-on ?device)))
    :effect
      (device-on ?device)
    :agents
      (?character)
  )

  ;; A character checks device connectivity.
  (:action check-connectivity
    :parameters
      (?character - character ?device - device)
    :precondition
      (and (awake ?character)
      (device-on ?device)
      (has-device ?character ?device))
    :effect
      (when (device-connected ?device)
        (working ?device))
    :agents
      (?character)
  )

  ;; A character goes outside.
  (:action go-outside
    :parameters
      (?character - character ?place - place)
    :precondition
      (and (awake ?character)
      (wearing-clothes ?character)
      (at ?character ?place))
    :effect
      (and (not (at ?character ?place))
      (at ?character outside))
    :agents
      (?character)
  )

  ;; A character talks to another character.
  (:action talk
    :parameters
      (?speaker - character ?listener - character)
    :precondition
      (and (awake ?speaker)
      (awake ?listener)
      (at ?speaker outside)
      (at ?listener outside))
    :effect
      (and)
    :agents
      (?speaker ?listener)
  )

  ;; School is canceled.
  (:action cancel-school
    :precondition
      (not (school-canceled))
    :effect
      (school-canceled)
  )
)