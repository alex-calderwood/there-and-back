(define (domain swing-time)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object)
  (:predicates
    (has-swing ?character - character)
    (playing-together ?character1 - character ?character2 - character)
    (happy ?character - character)
  )

  ;; A character invites another character to play on the swing.
  (:action invite
    :parameters
      (?inviter - character ?invitee - character)
    :precondition
      (and (not (= ?inviter ?invitee))
      (has-swing ?inviter))
    :effect
      (playing-together ?inviter ?invitee)
    :agents
      (?inviter)
  )

  ;; Two characters play on the swing together.
  (:action play-on-swing
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (playing-together ?character1 ?character2))
    :effect
      (and (happy ?character1)
      (happy ?character2))
    :agents
      (?character1 ?character2)
  )
)