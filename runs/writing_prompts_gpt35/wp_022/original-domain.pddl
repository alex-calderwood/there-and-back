(define (domain never-have-i-ever)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object)
  (:predicates
    (working ?person - person)
    (boss ?person - person)
    (told-boss ?person - person)
    (told-jenny ?person - person)
    (calling-police)
    (friends ?person - person)
    (backstabbed ?person - person)
    (drug-use)
    (walls-down)
    (attorney)
    (married ?person - person)
    (insulted-wife ?person - person)
    (birthday-party)
    (high-and-mighty ?person - person)
    (manager ?person - person)
    (ass-whooping)
  )

  ;; A person works at their job.
  (:action work-at
    :parameters
      (?person - person ?job - person)
    :precondition
      (and (not (working ?person))
      (boss ?job))
    :effect
      (working ?person)
    :agents
      (?person)
  )

  ;; A person tells their boss about a situation.
  (:action tell-boss
    :parameters
      (?person - person ?boss - person)
    :precondition
      (and (working ?person)
      (boss ?boss)
      (not (told-boss ?person)))
    :effect
      (told-boss ?person)
    :agents
      (?person)
  )

  ;; A person tells Jenny about a situation.
  (:action tell-jenny
    :parameters
      (?person - person)
    :precondition
      (and (not (told-jenny ?person)))
    :effect
      (told-jenny ?person)
    :agents
      (?person)
  )

  ;; A person calls the police.
  (:action call-police
    :precondition
      (not (calling-police))
    :effect
      (calling-police)
  )

  ;; Two people become friends.
  (:action become-friends
    :parameters
      (?person1 - person ?person2 - person)
    :precondition
      (and (not (friends ?person1 ?person2)))
    :effect
      (and (friends ?person1 ?person2)
      (friends ?person2 ?person1))
    :agents
      (?person1 ?person2)
  )

  ;; One person backstabs another.
  (:action backstab
    :parameters
      (?backstabber - person ?victim - person)
    :precondition
      (and (friends ?backstabber ?victim)
      (not (backstabbed ?backstabber ?victim)))
    :effect
      (backstabbed ?backstabber ?victim)
    :agents
      (?backstabber)
  )

  ;; A person uses drugs.
  (:action use-drugs
    :precondition
      (not (drug-use))
    :effect
      (drug-use)
  )

  ;; A person lets their walls down.
  (:action let-walls-down
    :precondition
      (not (walls-down))
    :effect
      (walls-down)
  )

  ;; A person hires an attorney.
  (:action hire-attorney
    :precondition
      (not (attorney))
    :effect
      (attorney)
  )

  ;; A person insults someone's wife.
  (:action insult-wife
    :parameters
      (?insulter - person ?wife - person)
    :precondition
      (and (married ?wife)
      (not (insulted-wife ?insulter ?wife)))
    :effect
      (insulted-wife ?insulter ?wife)
    :agents
      (?insulter)
  )

  ;; A person attends a birthday party.
  (:action attend-birthday-party
    :precondition
      (birthday-party)
    :effect
      (not (birthday-party))
  )

  ;; A person stops being high and mighty.
  (:action stop-high-and-mighty
    :parameters
      (?person - person)
    :precondition
      (and (high-and-mighty ?person)
      (manager ?person))
    :effect
      (not (high-and-mighty ?person))
    :agents
      (?person)
  )

  ;; A person gets an ass whooping.
  (:action get-ass-whooping
    :parameters
      (?person - person)
    :precondition
      (and (ass-whooping)
      (not (working ?person)))
    :effect
      (not (alive ?person))
    :agents
      (?person)
  )
)