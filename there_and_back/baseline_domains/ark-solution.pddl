(define (plan get-ark-solution)
  (:problem get-ark)
  (:steps
    (start)
    (travel indiana usa tanis)
    (excavate indiana ark tanis)
    (travel indiana tanis usa)
    (non-executed (give indiana ark army usa))
    (travel nazis tanis usa)
    (take nazis ark indiana usa)
    (open-ark nazis)
    (take army ark nazis usa)
    (end)
  )
)