(define (problem mistaken-identity)
  (:domain mistaken-identity)
  (:objects
    john-baker mistaken-jon-baker - character
    zudd mog general-yost-zed - character
    holding-deck flight-deck - object
    john-baker-translator mistaken-jon-baker-translator - object)
  (:init
    (abducted mistaken-jon-baker)
    (has mistaken-jon-baker john-baker-translator)
    (alive john-baker)
    (alive zudd)
    (alive mog)
    (alive general-yost-zed)
    (at john-baker flight-deck)
    (at zudd flight-deck)
    (at mog flight-deck)
    (at general-yost-zed holding-deck)
    (intends john-baker (alive john-baker))
    (intends john-baker (knows general-yost-zed (not (abducted john-baker)))))
  (:expression-variables
    (mistaken-jon-baker-expression - expression))
  (:goal
    (and (not (abducted john-baker))
    (knows general-yost-zed (abducted mistaken-jon-baker))))
  (:intentionality
    (intends john-baker (knows zudd (abducted mistaken-jon-baker)))
    (intends john-baker (knows mog (abducted mistaken-jon-baker)))
    (intends john-baker (knows mistaken-jon-baker mistaken-jon-baker-expression))
    (intends john-baker (not (knows general-yost-zed (abducted john-baker))))
    (intends zudd (alive zudd))
    (intends mog (alive mog))
    (intends general-yost-zed (not (knows zudd (abducted mistaken-jon-baker))))
    (intends general-yost-zed (not (knows mog (abducted mistaken-jon-baker))))
    (intends general-yost-zed (knows john-baker (abducted mistaken-jon-baker-expression))))
)