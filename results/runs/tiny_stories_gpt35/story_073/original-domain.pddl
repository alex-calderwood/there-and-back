(define (domain chess-game)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types chess-piece - object player - object)
  (:predicates
    (at ?piece - chess-piece ?location - object)
    (player-turn ?player - player)
    (shiny ?piece - chess-piece)
    (feeling-sick ?player - player)
    (wants-to-play ?player - player)
  )

  ;; A player moves a chess piece from one location to another.
  (:action move
    :parameters
      (?piece - chess-piece ?from - object ?to - object ?player - player)
    :precondition
      (and (at ?piece ?from)
      (player-turn ?player)
      (not (feeling-sick ?player))
      (not (shiny ?piece))
      (not (= ?from ?to)))
    :effect
      (and (not (at ?piece ?from))
      (at ?piece ?to)
      (not (player-turn ?player))
      (player-turn (not ?player)))
    :agents
      (?player)
  )

  ;; A player skips their turn.
  (:action skip-turn
    :parameters
      (?player - player)
    :precondition
      (and (player-turn ?player)
      (not (feeling-sick ?player)))
    :effect
      (not (player-turn ?player))
    :agents
      (?player)
  )

  ;; A player puts the shiny chess pieces away.
  (:action put-away-shiny-pieces
    :parameters
      (?player - player)
    :precondition
      (and (player-turn ?player)
      (not (feeling-sick ?player))
      (exists (?piece - chess-piece)
      (shiny ?piece)))
    :effect
      (forall (?piece - chess-piece)
      (when (shiny ?piece)
      (not (at ?piece ?location))))
    :agents
      (?player)
  )

  ;; A player sits with another player.
  (:action sit-with
    :parameters
      (?player1 - player ?player2 - player)
    :precondition
      (and (not (= ?player1 ?player2))
      (not (feeling-sick ?player1))
      (not (feeling-sick ?player2)))
    :effect
      (and (not (player-turn ?player1))
      (player-turn ?player2))
    :agents
      (?player1 ?player2)
  )
)