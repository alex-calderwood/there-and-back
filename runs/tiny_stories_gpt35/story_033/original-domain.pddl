(define (domain jack-and-his-friend)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants snack - expression)
  (:predicates
    (lying ?character - character ?expression - expression)
    (compassionate ?character - character)
    (has-snack ?character - character ?expression - expression)
    (crying ?character - character)
    (looking-back ?character - character)
    (disappointed ?character - character)
    (cautious ?character - character)
    (watching-out ?character - character)
  )

  ;; A character gives another character a snack.
  (:action give-snack
    :parameters
      (?giver - character ?receiver - character ?expression - expression)
    :precondition
      (and (alive ?giver)
      (alive ?receiver)
      (compassionate ?giver)
      (not (lying ?giver ?expression)))
    :effect
      (and (has-snack ?receiver ?expression))
    :agents
      (?giver ?receiver)
  )

  ;; A character lies about a snack.
  (:action lie
    :parameters
      (?character - character ?expression - expression)
    :precondition
      (and (alive ?character)
      (not (compassionate ?character)))
    :effect
      (lying ?character ?expression)
    :agents
      (?character)
  )

  ;; A character cries.
  (:action cry
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (crying ?character)
    :agents
      (?character)
  )

  ;; A character looks back.
  (:action look-back
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (looking-back ?character)
    :agents
      (?character)
  )

  ;; A character becomes disappointed.
  (:action become-disappointed
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (disappointed ?character)
    :agents
      (?character)
  )

  ;; A character becomes cautious.
  (:action become-cautious
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (cautious ?character)
    :agents
      (?character)
  )

  ;; A character watches out for lies.
  (:action watch-out
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (watching-out ?character)
    :agents
      (?character)
  )

  ;; A character becomes compassionate.
  (:action become-compassionate
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (compassionate ?character)
    :agents
      (?character)
  )
)