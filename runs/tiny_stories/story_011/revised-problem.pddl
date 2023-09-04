(define (problem garden-friends)
  (:domain
    garden-adventure)
  (:objects
    cat bird - character
    garden tree - place)
  (:init
    (interesting garden)
    (interesting tree)
    (at cat garden)
    (awake cat)
    (intends cat (not (awake cat)))
    (intends cat (friends cat bird))
    (at bird tree)
    (awake bird)
    (intends bird (singing bird))
    (intends bird (friends bird cat))
    (intends bird (at bird garden)))
  (:goal
    (and (friends cat bird)
    (at cat garden)
    (at bird garden)))
)