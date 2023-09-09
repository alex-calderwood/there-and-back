(define (domain breakup-recovery)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (feels-awful ?character - character)
    (thinks-about-breakup ?character - character)
    (heartbroken ?character - character)
    (forgiven ?character - character)
    (learned ?character - character)
    (moved-on ?character - character)
  )

  ;; A character forgives themselves.
  (:action forgive
    :parameters
      (?character - character)
    :precondition
      (and (feels-awful ?character)
      (not (forgiven ?character)))
    :effect
      (forgiven ?character)
    :agents
      (?character)
  )

  ;; A character learns from their experience.
  (:action learn
    :parameters
      (?character - character)
    :precondition
      (and (heartbroken ?character)
      (not (learned ?character)))
    :effect
      (learned ?character)
    :agents
      (?character)
  )

  ;; A character moves on from the breakup.
  (:action move-on
    :parameters
      (?character - character)
    :precondition
      (and (thinks-about-breakup ?character)
      (forgiven ?character)
      (learned ?character)
      (not (moved-on ?character)))
    :effect
      (moved-on ?character)
    :agents
      (?character)
  )
)