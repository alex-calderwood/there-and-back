(define (domain kitty-and-doggy)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (happy ?character - character)
    (nervous ?character - character)
    (can-play-with-yarn ?character - character)
    (helping ?helper - character ?helpee - character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :precondition
      (not (happy ?character))
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes nervous.
  (:action become-nervous
    :parameters
      (?character - character)
    :precondition
      (not (nervous ?character))
    :effect
      (nervous ?character)
    :agents
      (?character)
  )

  ;; A character asks for help.
  (:action ask-for-help
    :parameters
      (?asker - character ?helper - character)
    :precondition
      (not (helping ?helper ?asker))
    :effect
      (helping ?helper ?asker)
    :agents
      (?asker ?helper)
  )

  ;; A character learns to play with yarn.
  (:action learn-to-play-with-yarn
    :parameters
      (?character - character)
    :precondition
      (not (can-play-with-yarn ?character))
    :effect
      (can-play-with-yarn ?character)
    :agents
      (?character)
  )

  ;; When a character is happy, they are not nervous.
  (:axiom
    :vars
      (?character - character)
    :context
      (happy ?character)
    :implies
      (not (nervous ?character))
  )
)