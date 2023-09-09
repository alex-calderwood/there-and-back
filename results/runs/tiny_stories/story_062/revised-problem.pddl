(define (problem sara-and-spot-friends)
  (:domain
    sara-and-spot)
  (:objects
    sara tom - character
    spot big-brown-dog - dog
    red-ball - item)
  (:init
    (has-dog sara spot)
    (soft spot)
    (intends sara (happy sara))
    (intends sara (likes sara spot))
    (intends sara (friends sara tom))
    (intends sara (knows sara tom))
    (has tom red-ball)
    (has-dog tom big-brown-dog))
  (:goal
    (and (happy sara)
    (likes sara spot)
    (friends sara tom))
  )
)