(define (domain kindness-wisdom)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (friends ?c1 - character ?c2 - character)
    (kind ?character - character)
    (knows-wisdom ?character - character)
    (lost ?character - character)
    (found ?character - character)
  )

  ;; A character becomes kind.
  (:action become-kind
    :parameters
      (?character - character)
    :precondition
      (not (kind ?character))
    :effect
      (kind ?character)
    :agents
      (?character)
  )

  ;; A character learns wisdom.
  (:action learn-wisdom
    :parameters
      (?learner - character ?teacher - character)
    :precondition
      (and (not (knows-wisdom ?learner))
      (knows-wisdom ?teacher))
    :effect
      (knows-wisdom ?learner)
    :agents
      (?learner ?teacher)
  )

  ;; A character helps another character.
  (:action help
    :parameters
      (?helper - character ?helpee - character)
    :precondition
      (and (kind ?helper)
      (lost ?helpee))
    :effect
      (found ?helpee)
    :agents
      (?helper)
  )

  ;; Characters become friends.
  (:action become-friends
    :parameters
      (?c1 - character ?c2 - character)
    :precondition
      (and (not (friends ?c1 ?c2))
      (not (= ?c1 ?c2)))
    :effect
      (friends ?c1 ?c2)
    :agents
      (?c1 ?c2)
  )
)