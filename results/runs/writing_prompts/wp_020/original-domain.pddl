(define (domain emotional-support)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (hurting ?character - character)
    (struggling ?character - character)
    (loved ?character1 - character ?character2 - character)
    (letting-go ?character1 - character ?character2 - character)
    (ready ?character - character)
    (better-times ?character - character)
  )

  ;; A character acknowledges their pain.
  (:action acknowledge-pain
    :parameters
      (?character - character)
    :precondition
      (and (hurting ?character)
      (struggling ?character))
    :effect
      (not (struggling ?character))
    :agents
      (?character)
  )

  ;; A character lets go of their loved one.
  (:action let-go
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (loved ?character1 ?character2)
      (not (ready ?character2)))
    :effect
      (letting-go ?character1 ?character2)
    :agents
      (?character1)
  )

  ;; A character believes in better times.
  (:action believe-in-better-times
    :parameters
      (?character - character)
    :precondition
      (hurting ?character)
    :effect
      (better-times ?character)
    :agents
      (?character)
  )
)