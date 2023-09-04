(define (domain swing-mystery)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object)
  (:predicates
    (pushing-swing)
    (alive ?person - person)
    (murdered ?person - person)
    (knows ?person - person)
  )

  ;; A person pushes the swing.
  (:action push-swing
    :parameters
      (?person - person)
    :precondition
      (and (alive ?person)
      (not (pushing-swing)))
    :effect
      (pushing-swing)
    :agents
      (?person)
  )

  ;; A person stops pushing the swing.
  (:action stop-swing
    :precondition
      (pushing-swing)
    :effect
      (not (pushing-swing))
  )

  ;; A person is murdered.
  (:action murder
    :parameters
      (?victim - person ?killer - person)
    :precondition
      (and (alive ?victim)
      (alive ?killer)
      (not (= ?victim ?killer))
      (knows ?killer ?victim))
    :effect
      (and (not (alive ?victim))
      (murdered ?victim))
    :agents
      (?killer)
  )

  ;; A person learns something.
  (:action learn
    :parameters
      (?person - person ?fact - fact ?source - person)
    :precondition
      (and (alive ?person)
      (alive ?source)
      (knows ?source ?fact))
    :effect
      (knows ?person ?fact)
    :agents
      (?person)
  )
)