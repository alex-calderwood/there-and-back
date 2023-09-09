(define (domain big-boat-sailing)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (sailor ?character - character)
    (nice ?character - character)
    (sailing ?character - character)
    (together ?character1 - character ?character2 - character)
    (helping ?helper - character ?helpee - character)
  )

  ;; A character learns to sail.
  (:action learn-to-sail
    :parameters
      (?character - character)
    :effect
      (sailor ?character)
    :agents
      (?character)
  )

  ;; A character becomes nice.
  (:action become-nice
    :parameters
      (?character - character)
    :effect
      (nice ?character)
    :agents
      (?character)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :precondition
      (not (= ?helper ?helpee))
    :effect
      (helping ?helper ?helpee)
    :agents
      (?helper ?helpee)
  )

  ;; Two characters sail together.
  (:action sail-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (sailor ?character1)
      (sailor ?character2))
    :effect
      (together ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character thanks another character.
  (:action thank
    :parameters
      (?thanker - character ?thankee - character)
    :precondition
      (not (= ?thanker ?thankee))
    :effect
      (nice ?thanker)
    :agents
      (?thanker)
  )
)