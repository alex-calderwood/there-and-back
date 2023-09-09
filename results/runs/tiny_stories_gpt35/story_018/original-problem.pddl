(define (problem daisy-treasure-problem)
  (:domain daisy-treasure)
  (:objects
    chest toys - object
    coins - object)
  (:init
    (hidden chest)
    (treasure coins)
    (intends daisy (stored coins))
  )
  (:goal
    (and (stored coins)
         (not (hidden chest))))
)