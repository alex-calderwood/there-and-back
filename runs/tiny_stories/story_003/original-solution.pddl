(define (plan fix-bike-solution)
  (:problem fix-bike)
  (:steps (become-happy amy)
          (go-to-shop amy)
          (fix-pedal amy bike)
          (start-flying bike)))