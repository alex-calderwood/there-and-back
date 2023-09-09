(define (domain nightmare-control)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character monster - object)
  (:predicates
    (alive ?character - character)
    (trapped ?monster - monster)
    (impenetrable ?material - object)
    (made-of ?monster - monster ?material - object)
    (nightmare ?monster - monster)
    (in-dream ?character - character)
    (control-dream ?character - character)
    (face-of-deceased ?monster - monster ?character - character)
  )

  ;; A character gains control over their dream.
  (:action gain-control
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (in-dream ?character)
      (not (control-dream ?character)))
    :effect
      (control-dream ?character)
    :agents
      (?character)
  )

  ;; A character traps a monster in an impenetrable material.
  (:action trap-monster
    :parameters
      (?character - character ?monster - monster ?material - object)
    :precondition
      (and (alive ?character)
      (control-dream ?character)
      (nightmare ?monster)
      (impenetrable ?material)
      (not (trapped ?monster)))
    :effect
      (and (trapped ?monster)
      (made-of ?monster ?material))
    :agents
      (?character)
  )

  ;; A character releases a trapped monster.
  (:action release-monster
    :parameters
      (?character - character ?monster - monster)
    :precondition
      (and (alive ?character)
      (control-dream ?character)
      (trapped ?monster))
    :effect
      (not (trapped ?monster))
    :agents
      (?character)
  )

  ;; A character faces a monster with the face of a deceased person.
  (:action face-deceased
    :parameters
      (?character - character ?monster - monster ?deceased - character)
    :precondition
      (and (alive ?character)
      (nightmare ?monster)
      (not (face-of-deceased ?monster ?deceased)))
    :effect
      (face-of-deceased ?monster ?deceased)
    :agents
      (?character)
  )
)