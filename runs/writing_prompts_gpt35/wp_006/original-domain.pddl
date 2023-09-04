(define (domain star-wars-love-story)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (in-love ?character - character)
    (singing)
  )

  ;; A character sings a love song.
  (:action sing-love-song
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (and (singing)
      (in-love ?character ?other-character))
    :agents
      (?character)
  )

  ;; Two characters sing a love song together.
  (:action sing-duet
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (singing)
      (in-love ?character1 ?character2)
      (in-love ?character2 ?character1))
    :effect
      (and (not (singing))
      (in-love ?character1 ?character2)
      (in-love ?character2 ?character1))
    :agents
      (?character1 ?character2)
  )

  ;; A character forsakes their Jedi vows.
  (:action forsake-jedi-vows
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (not (jedi ?character))
    :agents
      (?character)
  )

  ;; A character forgets the past.
  (:action forget-past
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character))
    :effect
      (not (remembered-past ?character))
    :agents
      (?character)
  )

  ;; Two characters do something they need to do.
  (:action do-something
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (in-love ?character1 ?character2)
      (in-love ?character2 ?character1))
    :effect
      (and (not (in-love ?character1 ?character2))
      (not (in-love ?character2 ?character1)))
    :agents
      (?character1 ?character2)
  )
)