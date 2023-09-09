(define (problem little-girl-dress-problem)
  (:domain little-girl-dress)
  (:objects
    girl - girl
    red-yellow-flowers pink-roses - dress)
  (:init
    (has girl red-yellow-flowers)
    (comfy red-yellow-flowers)
    (intends girl (wearing girl red-yellow-flowers))
    (intends girl (smart girl))
    (intends girl (comfy red-yellow-flowers))
    (intends girl (has girl pink-roses)))
  (:goal
    (and (wearing girl pink-roses)
    (smart girl)
    (not (hole red-yellow-flowers))
    (not (wearing girl red-yellow-flowers))
    (not (comfy red-yellow-flowers))))
)