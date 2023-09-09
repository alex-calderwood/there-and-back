(define (problem monster-wardrobe-story)
  (:domain
    monster-wardrobe)
  (:objects
    sara ben - character
    sara-room - place)
  (:init
    (at sara sara-room)
    (at ben sara-room)
    (intends sara (dressed sara))
    (intends ben (dressed ben))
    (intends sara (holding-hands sara ben))
    (intends ben (holding-hands sara ben))
    (intends sara (kissing sara ben))
    (intends ben (kissing sara ben))
    (monster-in-wardrobe)
    (intends sara (not (eaten sara)))
    (intends ben (not (eaten ben)))
  )
  (:goal
    (and (not (eaten sara))
    (not (eaten ben))
    (kissing sara ben))
  )
)