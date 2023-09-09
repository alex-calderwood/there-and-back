(define (problem watch-tv)
  (:domain watching-tv)
  (:objects
    tim sue mom - character
    living-room - object)
  (:init
    (at tim living-room)
    (at sue living-room)
    (at mom living-room)
    (intends tim (not (rude tim))) ;; Tim intends to not be rude
    (intends tim (watching-tv))
    (intends sue (watching-tv))
    (intends mom (not (crying sue)))) ;; Mom intends to not cry
  (:goal
    (and (watching-tv)
    (nice tim)
    (nice sue)
    (not (crying sue)))
  )
)