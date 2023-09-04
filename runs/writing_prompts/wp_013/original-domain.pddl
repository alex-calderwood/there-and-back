(define (domain andrew-crow-transformation)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (human ?character - character)
    (crow ?character - character)
    (in-pain ?character - character)
    (sunlight-available)
    (transformed ?character - character)
  )

  ;; A character experiences pain.
  (:action experience-pain
    :parameters
      (?character - character)
    :precondition
      (human ?character)
    :effect
      (in-pain ?character)
    :agents
      (?character)
  )

  ;; A character transforms into a crow.
  (:action transform-into-crow
    :parameters
      (?character - character)
    :precondition
      (and (human ?character)
      (in-pain ?character)
      (sunlight-available))
    :effect
      (and (not (human ?character))
      (crow ?character)
      (transformed ?character))
    :agents
      (?character)
  )

  ;; A character transforms back into a human.
  (:action transform-back-into-human
    :parameters
      (?character - character)
    :precondition
      (crow ?character)
    :effect
      (and (not (crow ?character))
      (human ?character))
    :agents
      (?character)
  )
)