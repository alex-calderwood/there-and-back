(define (domain chess-sisters)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (play-chess ?character1 - character ?character2 - character)
    (feel-better ?character - character)
    (sit-together ?character1 - character ?character2 - character)
    (sick ?character - character)
    (happy ?character - character)
  )

  ;; Two characters play chess.
  (:action play-chess
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (sick ?character1))
      (not (sick ?character2))
      (not (= ?character1 ?character2)))
    :effect
      (play-chess ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character gets sick.
  (:action get-sick
    :parameters
      (?character - character)
    :effect
      (sick ?character)
    :agents
      (?character)
  )

  ;; A character feels better.
  (:action feel-better
    :parameters
      (?character - character)
    :precondition
      (sick ?character)
    :effect
      (not (sick ?character))
    :agents
      (?character)
  )

  ;; Two characters sit together.
  (:action sit-together
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (sit-together ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )
)