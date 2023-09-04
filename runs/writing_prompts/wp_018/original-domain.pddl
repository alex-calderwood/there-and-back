(define (domain grim-reaper)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (alive ?character - character)
    (dead ?character - character)
    (has-scythe ?character - character)
    (has-robe ?character - character)
    (retired ?character - character)
    (reaper ?character - character)
    (soul-called ?character - character)
  )

  ;; A character becomes the new Grim Reaper.
  (:action become-reaper
    :parameters
      (?character - character)
    :precondition
      (and (not (reaper ?character))
      (dead ?character))
    :effect
      (reaper ?character)
    :agents
      (?character)
  )

  ;; A character receives the scythe and robe.
  (:action receive-items
    :parameters
      (?giver - character ?receiver - character)
    :precondition
      (and (not (= ?giver ?receiver))
      (alive ?giver)
      (dead ?receiver)
      (has-scythe ?giver)
      (has-robe ?giver))
    :effect
      (and (not (has-scythe ?giver))
      (not (has-robe ?giver))
      (has-scythe ?receiver)
      (has-robe ?receiver))
    :agents
      (?giver ?receiver)
  )

  ;; A character retires.
  (:action retire
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (reaper ?character))
    :effect
      (retired ?character)
    :agents
      (?character)
  )

  ;; A character collects a soul.
  (:action collect-soul
    :parameters
      (?reaper - character ?soul - character)
    :precondition
      (and (reaper ?reaper)
      (has-scythe ?reaper)
      (has-robe ?reaper)
      (soul-called ?soul))
    :effect
      (not (soul-called ?soul))
    :agents
      (?reaper)
  )

  ;; When a character is dead, they are not alive.
  (:axiom
    :vars
      (?character - character)
    :context
      (and (alive ?character)
      (dead ?character))
    :implies
      (not (alive ?character))
  )
)