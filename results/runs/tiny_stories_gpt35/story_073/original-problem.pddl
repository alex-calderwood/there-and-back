(define (problem chess-game)
  (:domain chess-game)
  (:objects
    lucy mia - player
    king queen rook bishop knight pawn - chess-piece
    board window - object)
  (:init
    (at king board)
    (at queen board)
    (at rook board)
    (at bishop board)
    (at knight board)
    (at pawn board)
    (at window window)
    (player-turn lucy)
    (shiny king)
    (shiny queen)
    (shiny rook)
    (shiny bishop)
    (shiny knight)
    (shiny pawn)
    (wants-to-play lucy)
    (wants-to-play mia))
  (:goal
    (and (at king board)
    (at queen board)
    (at rook board)
    (at bishop board)
    (at knight board)
    (at pawn board)
    (not (feeling-sick lucy))
    (not (player-turn lucy))
    (player-turn mia)))
)