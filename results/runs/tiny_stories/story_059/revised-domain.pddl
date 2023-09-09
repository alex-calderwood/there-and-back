(define (domain kitty-buddy-puzzle)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (happy ?character - character)
    (sad ?character - character)
    (friends ?character1 - character ?character2 - character)
    (working-on-puzzle ?character - character)
    (puzzle-finished)
    (asked-for-help ?character1 - character ?character2 - character)
  )

  ;; A character asks another character for help.
  (:action ask-for-help
    :parameters
      (?asker - character ?helper - character)
    :precondition
      (and (not (= ?asker ?helper))
      (not (friends ?asker ?helper)))
    :effect
      (asked-for-help ?asker ?helper)
    :agents
      (?asker)
  )

  ;; A character agrees to help another character.
  (:action agree-to-help
    :parameters
      (?helper - character ?asker - character)
    :precondition
      (and (not (= ?helper ?asker))
      (asked-for-help ?asker ?helper))
    :effect
      (friends ?asker ?helper)
    :agents
      (?helper)
  )

  ;; A character works on the puzzle.
  (:action work-on-puzzle
    :parameters
      (?character - character)
    :precondition
      (and (friends ?character ?other - character)
      (not (puzzle-finished)))
    :effect
      (working-on-puzzle ?character)
    :agents
      (?character)
  )

  ;; A character finishes the puzzle.
  (:action finish-puzzle
    :parameters
      (?character - character)
    :precondition
      (and (working-on-puzzle ?character)
      (not (puzzle-finished)))
    :effect
      (puzzle-finished)
    :agents
      (?character)
  )

  ;; When a character is working on the puzzle, they are happy.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (happy ?character))
      (working-on-puzzle ?character))
    :implies
      (happy ?character)
  )

  ;; When a character is not working on the puzzle, they are sad.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (not (sad ?character))
      (not (working-on-puzzle ?character)))
    :implies
      (sad ?character)
  )
)