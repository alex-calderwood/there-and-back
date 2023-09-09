(define (problem tea-party-problem)
  (:domain tea-party)
  (:objects
    lily tom daisy - person
    tea-set cup saucer - item
    kitchen living-room - place)
  (:init
    (at lily living-room)
    (at tom living-room)
    (at daisy living-room)
    (at tea-set kitchen)
    (at cup tea-set)
    (at saucer tea-set)
    (intends lily (not (intends tom (broken tea-set))))
    (intends tom (intends lily (not (intends tom (broken tea-set))))))
  (:goal
    (and (not (broken tea-set))
    (intends lily (has lily cup))
    (intends lily (not (intends tom (broken tea-set))))
    (intends tom (not (intends lily (has lily cup))))
    (intends tom (intends lily (not (intends tom (broken tea-set)))))))
)