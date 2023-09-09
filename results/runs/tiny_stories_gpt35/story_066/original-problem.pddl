(define (problem tom-and-sue-gift)
  (:domain tom-and-sue)
  (:objects
    tom sue - character
    stone - gift
    forest - object)
  (:init
    (at tom forest)
    (at sue forest)
    (has-gift tom stone)
    (intends tom (has-gift sue stone))
    (intends sue (has-gift tom stone)))
  (:goal
    (and (has-gift tom stone)
    (has-gift sue stone)))
)