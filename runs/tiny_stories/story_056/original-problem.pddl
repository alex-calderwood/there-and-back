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
  )
  (:goal
    (and (eaten sara)
    (eaten ben))
  )
)