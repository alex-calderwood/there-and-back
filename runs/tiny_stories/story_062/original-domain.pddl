(define (domain sara-and-spot)
  (:requirements :adl :domain-axioms :intentionality)
  (:types character dog - object item - object)
  (:predicates
    (happy ?character - character)
    (has ?character - character ?item - item)
    (has-dog ?character - character ?dog - dog)
    (soft ?dog - dog)
    (scared ?character - character)
    (shy ?character - character)
    (knows ?character1 - character ?character2 - character)
    (likes ?character - character ?dog - dog)
    (friends ?character1 - character ?character2 - character)
  )

  ;; A character becomes happy.
  (:action become-happy
    :parameters
      (?character - character)
    :effect
      (happy ?character)
    :agents
      (?character)
  )

  ;; A character becomes scared.
  (:action become-scared
    :parameters
      (?character - character)
    :effect
      (scared ?character)
    :agents
      (?character)
  )

  ;; A character becomes shy.
  (:action become-shy
    :parameters
      (?character - character)
    :effect
      (shy ?character)
    :agents
      (?character)
  )

  ;; A character gets to know another character.
  (:action get-to-know
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (not (= ?character1 ?character2))
    :effect
      (knows ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )

  ;; A character likes a dog.
  (:action like-dog
    :parameters
      (?character - character ?dog - dog)
    :effect
      (likes ?character ?dog)
    :agents
      (?character)
  )

  ;; Two characters become friends.
  (:action become-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (not (= ?character1 ?character2))
      (knows ?character1 ?character2))
    :effect
      (friends ?character1 ?character2)
    :agents
      (?character1 ?character2)
  )
)