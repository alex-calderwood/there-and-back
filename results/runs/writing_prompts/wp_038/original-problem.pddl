(define (problem mistaken-abduction)
  (:domain
    alien-abduction)
  (:objects
    jon-baker john-baker zubb mog general-yost-zed - character
    earth alien-ship - place)
  (:init
    (at jon-baker earth)
    (at john-baker earth)
    (at zubb alien-ship)
    (at mog alien-ship)
    (at general-yost-zed alien-ship)
    (alive jon-baker)
    (alive john-baker)
    (alive zubb)
    (alive mog)
    (alive general-yost-zed)
    (intends jon-baker (alive jon-baker))
    (intends jon-baker (friends jon-baker zubb))
    (intends jon-baker (friends jon-baker mog))
    (intends zubb (alive zubb))
    (intends zubb (not (knows-mistake general-yost-zed zubb)))
    (intends mog (alive mog))
    (intends mog (not (knows-mistake general-yost-zed mog)))
    (intends general-yost-zed (abducted john-baker))
  )
  (:goal
    (and (abducted john-baker)
    (not (knows-mistake general-yost-zed zubb))
    (not (knows-mistake general-yost-zed mog))
    (friends jon-baker zubb)
    (friends jon-baker mog))
  )
)