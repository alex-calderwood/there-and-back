(define (problem swing-mystery)
  (:domain swing-mystery)
  (:objects
    steven irene old-man - person)
  (:init
    (alive steven)
    (alive old-man)
    (not (alive irene))
    (not (pushing-swing))
    (knows old-man irene)
    (knows steven old-man)
    (intends steven (not (pushing-swing)))
    (intends old-man (pushing-swing)))
  (:goal
    (and (not (alive steven))
    (murdered steven)))
)