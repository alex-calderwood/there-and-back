(define (domain carnival)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (at-carnival ?character - character)
    (wants-to-play ?character - character)
    (played ?character - character)
    (weight-too-low ?character - character)
    (upset ?character - character)
    (comforted ?character - character)
  )

  ;; A character goes to the carnival.
  (:action go-to-carnival
    :parameters
      (?character - character)
    :effect
      (at-carnival ?character)
    :agents
      (?character)
  )

  ;; A character wants to play a game.
  (:action want-to-play
    :parameters
      (?character - character)
    :precondition
      (at-carnival ?character)
    :effect
      (wants-to-play ?character)
    :agents
      (?character)
  )

  ;; A character plays the game and gets a weight too low result.
  (:action play-game
    :parameters
      (?character - character)
    :precondition
      (and (at-carnival ?character)
      (wants-to-play ?character))
    :effect
      (and (played ?character)
      (weight-too-low ?character))
    :agents
      (?character)
  )

  ;; A character becomes upset.
  (:action become-upset
    :parameters
      (?character - character)
    :precondition
      (weight-too-low ?character)
    :effect
      (upset ?character)
    :agents
      (?character)
  )

  ;; A character tries to comfort another character.
  (:action comfort
    :parameters
      (?comforter - character ?comforted - character)
    :precondition
      (and (not (= ?comforter ?comforted))
      (upset ?comforted))
    :effect
      (comforted ?comforted)
    :agents
      (?comforter)
  )
)