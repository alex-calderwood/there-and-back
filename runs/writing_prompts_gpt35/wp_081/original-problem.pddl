(define (problem face-recognition-problem)
  (:domain face-recognition)
  (:objects
    old-face new-face - face
    sadness joy fury wisdom forgiveness - emotion)
  (:init
    (same-face old-face old-face)
    (has-emotion old-face sadness)
    (has-emotion old-face joy)
    (has-emotion old-face fury)
    (has-emotion old-face wisdom)
    (has-emotion old-face forgiveness)
    (intends old-face (same-face old-face new-face)))
  (:goal
    (and (same-face old-face new-face)
    (has-emotion new-face sadness)
    (has-emotion new-face joy)
    (has-emotion new-face fury)
    (has-emotion new-face wisdom)
    (has-emotion new-face forgiveness)))
)