(define (domain bella-escape)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character - object cage - item)
  (:predicates
    (in-cage ?character - character ?cage - cage)
    (broken ?cage - cage)
    (free ?character - character)
    (friends ?character1 - character ?character2 - character)
  )

  ;; A character breaks a cage.
  (:action break-cage
    :parameters
      (?character - character ?cage - cage)
    :precondition
      (and (in-cage ?character ?cage)
      (not (broken ?cage)))
    :effect
      (broken ?cage)
    :agents
      (?character)
  )

  ;; A character escapes from a broken cage.
  (:action escape
    :parameters
      (?character - character ?cage - cage)
    :precondition
      (and (in-cage ?character ?cage)
      (broken ?cage))
    :effect
      (and (not (in-cage ?character ?cage))
      (free ?character))
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (not (friends ?character1 ?character2)))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)