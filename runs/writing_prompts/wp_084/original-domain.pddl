(define (domain love-confession)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (loves ?lover - character ?loved - character)
    (confessed ?confessor - character ?confessed-to - character)
    (asked-question ?asker - character ?asked - character)
    (took-pill ?character - character)
  )

  ;; A character takes the pill.
  (:action take-pill
    :parameters
      (?character - character)
    :precondition
      (not (took-pill ?character))
    :effect
      (took-pill ?character)
    :agents
      (?character)
  )

  ;; A character asks another character if they love them.
  (:action ask-love-question
    :parameters
      (?asker - character ?asked - character)
    :precondition
      (not (asked-question ?asker ?asked))
    :effect
      (asked-question ?asker ?asked)
    :agents
      (?asker)
  )

  ;; A character confesses their love to another character.
  (:action confess-love
    :parameters
      (?confessor - character ?confessed-to - character)
    :precondition
      (and (not (confessed ?confessor ?confessed-to))
      (asked-question ?confessed-to ?confessor)
      (took-pill ?confessor))
    :effect
      (and (confessed ?confessor ?confessed-to)
      (loves ?confessor ?confessed-to))
    :agents
      (?confessor)
  )
)