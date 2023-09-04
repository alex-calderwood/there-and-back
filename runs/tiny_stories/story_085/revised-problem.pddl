(define (problem tea-party-problem)
  (:domain
    tea-party)
  (:objects
    lily tom mother - character
    tea-set cup saucer - item)
  (:init
    (has lily tea-set)
    (has lily cup)
    (has lily saucer)
    (intends lily (playing lily tea-set))
    (intends tom (broken cup))
    (intends mother (apologized tom lily))
    (intends mother (cleaned tom))
    (intends lily (forgiven mother tom))
  )
  (:goal
    (and (broken cup)
    (apologized tom lily)
    (cleaned tom)
    (forgiven mother tom))
  )
)