(define (domain face-recognition)
  (:requirements :strips :typing :equality)
  (:types face - object emotion - object)
  (:predicates
    (same-face ?face1 - face ?face2 - face)
    (has-emotion ?face - face ?emotion - emotion)
  )

  ;; A face changes to a new face.
  (:action change-face
    :parameters
      (?old-face - face ?new-face - face)
    :precondition
      (and (not (= ?old-face ?new-face))
      (same-face ?old-face ?old-face))
    :effect
      (and (same-face ?new-face ?new-face)
      (not (same-face ?old-face ?old-face)))
  )

  ;; A face has an emotion.
  (:action express-emotion
    :parameters
      (?face - face ?emotion - emotion)
    :precondition
      (same-face ?face ?face)
    :effect
      (has-emotion ?face ?emotion)
  )
)