(define (problem greek-lovers-problem)
  (:domain
    greek-lovers)
  (:objects
    diana artemia agapios - character
    twins - family
    women-city - place)
  (:init
    (lover diana agapios)
    (mother artemia diana)
    (male agapios)
    (female diana)
    (at diana women-city)
    (intends diana (traveling diana))
    (intends diana (family artemia agapios))
    (intends diana (ill diana))
    (intends diana (separated agapios))
    (intends artemia (family diana agapios))
    (intends artemia (sentimental d