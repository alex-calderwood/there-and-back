(define (domain the-six)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants queen-raquel roth - character)
  (:predicates
    (alive ?character - character)
    (friends ?character1 - character ?character2 - character)
    (enemies ?character1 - character ?character2 - character)
    (betrayed ?character1 - character ?character2 - character)
    (heart-won ?character1 - character ?character2 - character)
    (on-break ?character1 - character ?character2 - character)
  )

  ;; A character travels from one place to another.
  (:action travel
    :parameters
      (?character - character ?from - expression ?to - expression)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (at ?character ?from))
    :effect  (and (not (at ?character ?from))
      (at ?character ?to))
    :agents  (?character)
  )

  ;; Two characters become friends.
  (:action make-friends
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (friends ?character1 ?character2)))
    :effect
      (and (friends ?character1 ?character2)
      (friends ?character2 ?character1))
    :agents
      (?character1 ?character2)
  )

  ;; Two characters become enemies.
  (:action make-enemies
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (not (enemies ?character1 ?character2)))
    :effect
      (and (enemies ?character1 ?character2)
      (enemies ?character2 ?character1))
    :agents
      (?character1 ?character2)
  )

  ;; One character betrays another.
  (:action betray
    :parameters
      (?betrayed - character ?betrayee - character)
    :precondition
      (and (alive ?betrayed)
      (alive ?betrayee)
      (friends ?betrayed ?betrayee)
      (not (betrayed ?betrayed ?betrayee)))
    :effect
      (and (betrayed ?betrayed ?betrayee)
      (not (friends ?betrayed ?betrayee)))
    :agents
      (?betrayed)
  )

  ;; One character wins back the heart of another.
  (:action win-heart
    :parameters
      (?winner - character ?loser - character)
    :precondition
      (and (alive ?winner)
      (alive ?loser)
      (enemies ?winner ?loser)
      (betrayed ?loser ?winner)
      (not (heart-won ?winner ?loser)))
    :effect
      (and (heart-won ?winner ?loser)
      (friends ?winner ?loser)
      (friends ?loser ?winner))
    :agents
      (?winner)
  )

  ;; Two characters go on a break.
  (:action go-on-break
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (friends ?character1 ?character2)
      (not (on-break ?character1 ?character2)))
    :effect
      (and (on-break ?character1 ?character2)
      (on-break ?character2 ?character1))
    :agents
      (?character1 ?character2)
  )

  ;; Two characters end their break.
  (:action end-break
    :parameters
      (?character1 - character ?character2 - character)
    :precondition
      (and (alive ?character1)
      (alive ?character2)
      (friends ?character1 ?character2)
      (on-break ?character1 ?character2))
    :effect
      (and (not (on-break ?character1 ?character2))
      (not (on-break ?character2 ?character1)))
    :agents
      (?character1 ?character2)
  )
)