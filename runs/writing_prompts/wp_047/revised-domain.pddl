(define (domain world-unity)
  (:requirements :adl :domain-axioms :intentionality)
  (:types nation - object)
  (:predicates
    (at-peace ?nation - nation)
    (sharing-technology ?nation1 - nation ?nation2 - nation)
    (advanced-technology ?nation - nation)
    (facing-destruction)
  )

  ;; Nations unite to face destruction.
  (:action unite
    :parameters
      (?nation1 - nation ?nation2 - nation)
    :precondition
      (and (not (= ?nation1 ?nation2))
      (facing-destruction))
    :effect
      (and (at-peace ?nation1)
      (at-peace ?nation2)
      (sharing-technology ?nation1 ?nation2))
    :agents
      (?nation1 ?nation2)
  )

  ;; Nations develop advanced technology together.
  (:action develop-technology
    :parameters
      (?nation1 - nation ?nation2 - nation)
    :precondition
      (and (not (= ?nation1 ?nation2))
      (sharing-technology ?nation1 ?nation2))
    :effect
      (and (advanced-technology ?nation1)
      (advanced-technology ?nation2))
    :agents
      (?nation1 ?nation2)
  )

  ;; Nations avoid destruction.
  (:action avoid-destruction
    :precondition
      (and (advanced-technology nation1)
      (advanced-technology nation2)
      (advanced-technology nation3))
    :effect
      (not (facing-destruction))
  )

  ;; Nations maintain peace and technology sharing.
  (:action maintain-peace
    :parameters
      (?nation1 - nation ?nation2 - nation)
    :precondition
      (and (not (= ?nation1 ?nation2))
      (at-peace ?nation1)
      (at-peace ?nation2)
      (sharing-technology ?nation1 ?nation2))
    :effect
      (and (at-peace ?nation1)
      (at-peace ?nation2)
      (sharing-technology ?nation1 ?nation2))
    :agents
      (?nation1 ?nation2)
  )
)