(define (plan robbery-solution)
  (:problem robbery)
  (:steps (snakebite timmy)
          (travel hank ranch generalstore)
          (tieup hank carl generalstore)
          (take hank antivenom carl generalstore)
          (die timmy snakebite)
          (non-executed (travel timmy ranch generalstore))
          (snakebite hank)
          (non-executed (heal hank timmy snakebite antivenom generalstore))))