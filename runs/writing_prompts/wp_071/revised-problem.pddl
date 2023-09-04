(define (problem christmas-conspiracy)
  (:domain
    christmas-conspiracy)
  (:objects
    reporter mrs-c elf1 elf2 - character
    diner - place
    envelope - item
    ak47-1 ak47-2 - weapon)
  (:init
    (at reporter diner)
    (alive reporter)
    (intends reporter (published envelope))
    (intends reporter (alive reporter))
    (intends reporter (alive mrs-c))
    (at mrs-c diner)
    (alive mrs-c)
    (has mrs-c envelope)
    (intends mrs-c (published envelope))
    (intends mrs-c (alive mrs-c))
    (intends mrs-c (alive reporter))
    (at elf1 diner)
    (alive elf1)
    (has elf1 ak47-1)
    (intends elf1 (not (alive reporter)))
    (intends elf1 (not (alive mrs-c)))
    (at elf2 diner)
    (alive elf2)
    (has elf2 ak47-2)
    (intends elf2 (not (alive reporter)))
    (intends elf2 (not (alive mrs-c)))
  )
  (:goal
    (and (published envelope)
    (alive reporter)
    (alive mrs-c)
    (not (alive elf1))
    (not (alive elf2)))
  )
)