(define (plan eat-apple-solution)
  (:problem eat-apple)
  (:steps (help ant ant)
          (break-object ant apple ant)
          (eat-together ant ant apple)))