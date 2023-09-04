(define (problem man-shape-suicide)
  (:domain man-shape)
  (:objects
    man-shape-1 man-shape-2 - man-shape
    location-1 location-2 - object)
  (:init
    (alive man-shape-1)
    (at man-shape-1 location-1)
    (carries man-shape-1 gun)
    (alive man-shape-2)
    (at man-shape-2 location-2)
    (enemy man-shape-2)
    (intends man-shape-1 (walk man-shape-1 location-2))
    (intends man-shape-1 (fire man-shape-1 man-shape-2 bullet))
    (intends man-shape-2 (walk man-shape-2 location-1))
    (intends man-shape-2 (fire man-shape-2 man-shape-1 bullet))
    (has location-1 bullet)
    (has location-2 gun)
    (intends man-shape-1 (suicide man-shape-1)))
  (:goal
    (not (alive man-shape-1))
  )
)