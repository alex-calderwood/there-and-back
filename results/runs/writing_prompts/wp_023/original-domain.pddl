(define (domain thomas-fredson-death)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (dead ?character - character)
    (has-plan ?character - character)
    (has-time ?character - character)
    (has-idea ?character - character)
    (has-tv-show-reference ?character - character)
    (has-creative-plan ?character - character)
    (has-better-plan ?character - character)
  )

  ;; A character presents their plan.
  (:action present-plan
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (has-plan ?character))
    :effect
      (and (has-idea ?character)
      (when (has-tv-show-reference ?character)
        (not (has-creative-plan ?character))))
    :agents  (?character)
  )

  ;; The high council decides the fate of a character.
  (:action decide-fate
    :parameters
      (?council - character ?character - character)
    :precondition
      (and (alive ?council)
      (alive ?character)
      (has-idea ?character))
    :effect
      (when (has-creative-plan ?character)
        (and (has-better-plan ?character)
        (has-time ?character)))
    :agents  (?council)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (has-time ?character)))
    :effect
      (dead ?character)
    :agents  (?character)
  )
)