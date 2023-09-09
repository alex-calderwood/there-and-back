(define (domain post-apocalyptic-world)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object place - object item - object)
  (:predicates
    (alive ?character - character)
    (at ?character - character ?place - place)
    (has ?character - character ?item - item)
    (knows-survival-skills ?character - character)
    (computers-working)
    (caused-apocalypse ?character - character)
  )

  ;; A character learns survival skills from another character.
  (:action learn-survival-skills
    :parameters
      (?learner - character ?teacher - character)
    :precondition
      (and (alive ?learner)
      (alive ?teacher)
      (knows-survival-skills ?teacher)
      (not (knows-survival-skills ?learner)))
    :effect
      (knows-survival-skills ?learner)
    :agents
      (?learner ?teacher)
  )

  ;; A character causes the apocalypse by stopping all computers.
  (:action cause-apocalypse
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (computers-working))
    :effect
      (and (not (computers-working))
      (caused-apocalypse ?character))
    :agents
      (?character)
  )

  ;; A character is killed by another character.
  (:action kill
    :parameters
      (?killer - character ?victim - character)
    :precondition
      (and (alive ?killer)
      (alive ?victim)
      (not (= ?killer ?victim)))
    :effect
      (not (alive ?victim))
    :agents
      (?killer)
  )
)