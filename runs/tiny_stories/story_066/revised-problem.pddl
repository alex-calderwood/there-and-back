(define (problem surprise-gifts)
  (:domain
    surprise-gifts)
  (:objects
    tom sue - character
    forest - place
    stone - item)
  (:init
    (at tom forest)
    (at sue forest)
    (intends tom (gave-gift tom sue stone))
    (intends tom (happy tom))
    (intends tom (happy sue))
    (intends sue (happy sue))
  )
  (:goal
    (and (gave-gift tom sue stone)
    (happy tom)
    (happy sue))
  )
)