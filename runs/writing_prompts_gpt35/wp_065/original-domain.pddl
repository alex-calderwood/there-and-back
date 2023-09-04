(define (domain apocalypse)
  (:requirements :adl :expression-variables :intentionality)
  (:types character - object)
  (:constants
    bunker - object
    bombs - object
  )
  (:predicates
    (alive ?character - character)
    (has-followers ?character - character)
    (in-bunker ?character - character)
    (in-possession ?character - character ?object - object)
    (launched ?object - object)
    (game-over)
  )

  ;; A character moves from one location to another.
  (:action move
    :parameters
      (?character - character ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (alive ?character)
      (in-possession ?character ?from))
    :effect
      (and (not (in-possession ?character ?from))
      (in-possession ?character ?to))
    :agents
      (?character)
  )

  ;; A character launches an object.
  (:action launch
    :parameters
      (?character - character ?object - object)
    :precondition
      (and (alive ?character)
      (in-possession ?character ?object))
    :effect
      (and (not (in-possession ?character ?object))
      (launched ?object))
    :agents
      (?character)
  )

  ;; A character dies.
  (:action die
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (and (not (alive ?character))
      (not (has-followers ?character)))
    :agents
      (?character)
  )

  ;; The game ends.
  (:action end-game
    :precondition
      (and (launched bombs)
      (not (alive disease)))
    :effect
      (game-over)
  )

  ;; A character loses their last follower.
  (:action lose-followers
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (not (has-followers ?character)))
    :effect
      (and (not (alive ?character)))
    :agents
      (?character)
  )

  ;; A character gains a follower.
  (:action gain-followers
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (has-followers ?character)
    :agents
      (?character)
  )

  ;; A character enters the bunker.
  (:action enter-bunker
    :parameters
      (?character - character)
    :precondition
      (alive ?character)
    :effect
      (in-bunker ?character)
    :agents
      (?character)
  )

  ;; A character exits the bunker.
  (:action exit-bunker
    :parameters
      (?character - character)
    :precondition
      (and (alive ?character)
      (in-bunker ?character))
    :effect
      (not (in-bunker ?character))
    :agents
      (?character)
  )

  ;; A character intends to win the game.
  (:expression (intends-to-win ?character - character)
    :parameters
      (?character - character)
    :value
      (and (not (game-over))
      (or (and (launched bombs)
      (not (alive disease)))
      (and (not (launched bombs))
      (alive disease)
      (not (in-bunker disease))))))

  ;; A character intends to launch the bombs.
  (:expression (intends-to-launch ?character - character)
    :parameters
      (?character - character)
    :value
      (and (not (launched bombs))
      (in-bunker ?character))))

)