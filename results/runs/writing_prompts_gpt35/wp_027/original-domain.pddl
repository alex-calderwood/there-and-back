(define (domain matrix-glitch)
  (:requirements :adl :expression-variables :intentionality)
  (:types person - object)
  (:constants jennah mila - person)
  (:predicates
    (naked ?person - person)
    (stuck ?person - person)
    (fallen ?person - person)
    (digging ?person - person)
    (helping ?person - person)
    (panicked ?person - person)
    (crying ?person - person)
    (chanted ?person - person)
    (bearded ?person - person)
    (slapped ?person - person)
    (felt-glitch)
  )

  ;; A person helps another person who is stuck.
  (:action help
    :parameters
      (?helper - person ?stuck-person - person)
    :precondition
      (and (not (= ?helper ?stuck-person))
      (naked ?helper)
      (stuck ?stuck-person))
    :effect
      (and (not (stuck ?stuck-person))
      (helping ?helper)
      (not (naked ?helper)))
    :agents
      (?helper)
  )

  ;; A person falls from the sky.
  (:action fall
    :parameters
      (?person - person)
    :precondition
      (not (fallen ?person))
    :effect
      (and (fallen ?person)
      (naked ?person))
    :agents
      (?person)
  )

  ;; A person digs themselves out from under dirt and grass.
  (:action dig
    :parameters
      (?person - person)
    :precondition
      (and (fallen ?person)
      (not (digging ?person)))
    :effect
      (and (digging ?person)
      (not (naked ?person)))
    :agents
      (?person)
  )

  ;; A person panics.
  (:action panic
    :parameters
      (?person - person)
    :precondition
      (not (panicked ?person))
    :effect
      (panicked ?person)
    :agents
      (?person)
  )

  ;; A person cries.
  (:action cry
    :parameters
      (?person - person)
    :precondition
      (not (crying ?person))
    :effect
      (crying ?person)
    :agents
      (?person)
  )

  ;; A person chants.
  (:action chant
    :parameters
      (?person - person)
    :precondition
      (and (bearded ?person)
      (not (chanted ?person))))
    :effect
      (chanted ?person)
    :agents
      (?person)
  )

  ;; A person is slapped.
  (:action slap
    :parameters
      (?slapper - person ?slapped - person)
    :precondition
      (and (not (= ?slapper ?slapped))
      (panicked ?slapper)
      (crying ?slapped))
    :effect
      (slapped ?slapped)
    :agents
      (?slapper)
  )

  ;; A person feels a glitch in the Matrix.
  (:action feel-glitch
    :parameters
      ()
    :precondition
      (not (felt-glitch))
    :effect
      (felt-glitch)
  )
)