(define (domain apocalypse-game)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character god - object bunker - place)
  (:predicates
    (in-bunker ?character - character ?bunker - bunker)
    (alive ?character - character)
    (has-followers ?god - god)
    (launching-bombs ?character - character)
    (disease-spreading)
    (bombs-launched)
  )

  ;; A character enters a bunker.
  (:action enter-bunker
    :parameters
      (?character - character ?bunker - bunker)
    :precondition
      (and (alive ?character)
      (not (in-bunker ?character ?bunker)))
    :effect
      (in-bunker ?character ?bunker)
    :agents
      (?character)
  )

  ;; A character launches bombs.
  (:action launch-bombs
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (exists (?bunker - bunker)
      (in-bunker ?character ?bunker)))
    :effect
      (launching-bombs ?character)
    :agents
      (?character)
  )

  ;; Disease spreads.
  (:action spread-disease
    :precondition
      (not (disease-spreading))
    :effect
      (disease-spreading)
  )

  ;; Bombs are launched.
  (:action bombs-launched
    :precondition
      (exists (?character - character)
      (launching-bombs ?character))
    :effect
      (bombs-launched)
  )

  ;; When a character is in a bunker, they are safe from disease.
  (:axiom
    :vars
      (?character - character ?bunker - bunker)
    :context
      (and (in-bunker ?character ?bunker)
      (disease-spreading))
    :implies
      (not (alive ?character))
  )

  ;; When bombs are launched, all characters outside bunkers die.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (bombs-launched)
      (forall (?bunker - bunker)
      (not (in-bunker ?character ?bunker))))
    :implies
      (not (alive ?character))
  )
)