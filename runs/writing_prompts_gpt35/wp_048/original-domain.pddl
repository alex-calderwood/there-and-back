(define (domain death-and-rebirth)
  (:requirements :adl :expression-variables :intentionality)
  (:types person - object)
  (:constants death - person)
  (:predicates
    (alive ?person - person)
    (has-task ?person - person)
    (completed-blood ?person - person)
    (completed-sweat ?person - person)
    (completed-tears ?person - person)
    (in-pain ?person - person)
    (reborn ?person - person)
    (helped ?person - person)
    (built-torture-chambers ?person - person)
    (collapsed ?person - person)
    (puddle ?person - person)
  )

  ;; A person chooses a task.
  (:action choose-task
    :parameters
      (?person - person ?task - expression)
    :precondition
      (and (alive ?person)
      (not (has-task ?person)))
    :effect
      (and (has-task ?person)
      (imply ?task
        (and (alive ?person)
        (in-pain ?person))))
    :agents
      (?person)
  )

  ;; A person suffers Blood.
  (:action suffer-blood
    :parameters
      (?person - person)
    :precondition
      (and (alive ?person)
      (has-task ?person)
      (imply (eq ?person death)
        (not (completed-blood ?person)))))
    :effect
      (and (not (in-pain ?person))
      (reborn ?person)
      (completed-blood ?person))
    :agents
      (?person)
  )

  ;; A person helps with Sweat.
  (:action help-sweat
    :parameters
      (?person - person ?other - person)
    :precondition
      (and (alive ?person)
      (has-task ?person)
      (not (completed-sweat ?person))
      (alive ?other)
      (in-pain ?other))
    :effect
      (and (not (in-pain ?other))
      (helped ?person)
      (completed-sweat ?person))
    :agents
      (?person)
  )

  ;; A person builds torture chambers.
  (:action build-torture-chambers
    :parameters
      (?person - person)
    :precondition
      (and (alive ?person)
      (has-task ?person)
      (not (completed-sweat ?person))
      (not (built-torture-chambers ?person))))
    :effect
      (and (built-torture-chambers ?person)
      (completed-sweat ?person))
    :agents
      (?person)
  )

  ;; A person collapses into a puddle of Tears.
  (:action collapse
    :parameters
      (?person - person)
    :precondition
      (and (alive ?person)
      (has-task ?person)
      (not (completed-tears ?person))))
    :effect
      (and (not (alive ?person))
      (collapsed ?person)
      (puddle ?person)
      (completed-tears ?person))
    :agents
      (?person)
  )

  ;; A person is reborn.
  (:axiom
    :vars
      (?person - person)
    :context
      (and (reborn ?person)
      (exists (?other - person)
      (in-pain ?other)))
    :implies
      (not (reborn ?person))
  )

  ;; A person is helped.
  (:axiom
    :vars
      (?person - person)
    :context
      (and (helped ?person)
      (exists (?other - person)
      (in-pain ?other)))
    :implies
      (not (in-pain ?person))
  )

  ;; A person is in pain if they have not completed a task.
  (:axiom
    :vars
      (?person - person)
    :context
      (and (alive ?person)
      (has-task ?person)
      (not (or (completed-blood ?person)
      (completed-sweat ?person)
      (completed-tears ?person)))))
    :implies
      (in-pain ?person)
  )
)