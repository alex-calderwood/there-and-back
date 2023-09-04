(define (problem sara-and-spot-park)
  (:domain
    sara-and-spot)
  (:objects
    sara tom - character
    spot sara-dog tom-dog - animal
    park ball - object)
  (:init
    (at sara-dog park)
    (has sara sara-dog)
    (friendly sara-dog)
    (at sara park)
    (intends sara (happy sara))
    (intends sara (not (scared sara)))
    (at tom park)
    (has tom tom-dog)
    (friendly tom-dog)
    (intends tom (not (scared tom))))
  (:goal
    (and (happy sara)
    (happy spot)
    (not (scared sara))
    (not (scared tom))
    (at sara park)
    (at tom park)
    (at spot park)
    (friendly spot)
    (friendly tom-dog)
    (not (scared sara-dog))
    (not (scared tom-dog))
    (intends sara (not (scared sara-dog))))
  )
)