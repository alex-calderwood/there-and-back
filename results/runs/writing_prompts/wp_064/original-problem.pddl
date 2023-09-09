(define (problem deliver-gift-card)
  (:domain
    mail-delivery)
  (:objects
    you penny cyclist old-man young-girl - character
    home street-corner mailbox - place
    envelope - item)
  (:init
    (alive you)
    (at you home)
    (has you envelope)
    (intends you (delivered envelope))
    (alive penny)
    (at penny home)
    (alive cyclist)
    (at cyclist street-corner)
    (alive old-man)
    (at old-man street-corner)
    (alive young-girl)
    (at young-girl street-corner))
  (:goal
    (delivered envelope))
)