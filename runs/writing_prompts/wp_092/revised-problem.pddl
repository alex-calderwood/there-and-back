(define (problem family-meeting)
  (:domain
    family-meeting)
  (:objects
    diana artemia daughter1 daughter2 agapios - character
    womens-city mens-city - place)
  (:init
    (at diana womens-city)
    (at artemia womens-city)
    (at daughter1 womens-city)
    (at daughter2 womens-city)
    (at agapios womens-city)
    (has-child diana agapios)
    (has-child artemia diana)
    (intends diana (at diana mens-city))
    (intends diana (is-grandmother artemia))
    (intends artemia (at artemia mens-city))
    (intends daughter1 (at daughter1 mens-city))
    (intends daughter2 (at daughter2 mens-city))
  )
  (:goal
    (and (at diana mens-city)
    (at artemia mens-city)
    (at daughter1 mens-city)
    (at daughter2 mens-city)
    (is-grandmother artemia))
  )
)