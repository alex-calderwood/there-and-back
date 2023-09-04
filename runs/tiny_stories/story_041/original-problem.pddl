(define (problem kindness-wisdom-story)
  (:domain
    kindness-wisdom)
  (:objects
    billy tommy baby-bunny mommy-bunny - character)
  (:init
    (friends billy tommy)
    (kind billy)
    (knows-wisdom billy)
    (intends billy (kind billy))
    (intends billy (friends billy tommy))
    (intends billy (friends billy baby-bunny))
    (intends billy (friends billy mommy-bunny))
    (intends tommy (kind tommy))
    (intends tommy (friends tommy billy))
    (intends tommy (friends tommy baby-bunny))
    (intends tommy (friends tommy mommy-bunny))
    (lost baby-bunny))
  (:goal
    (and (friends billy baby-bunny)
    (friends billy mommy-bunny)
    (friends tommy baby-bunny)
    (friends tommy mommy-bunny)
    (found baby-bunny)
    (kind tommy)
    (knows-wisdom tommy))
  )
)