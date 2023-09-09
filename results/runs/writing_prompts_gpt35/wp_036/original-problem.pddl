(define (problem light-creator-problem)
  (:domain light-creator)
  (:objects
    protagonist - object
    dorm-room workshop grounds - object
    lightbox1 lightbox2 lightbox3 - object
    mirror1 mirror2 mirror3 - object
    button1 button2 button3 - object
    spark - object
    fire1 fire2 fire3 - object
  )
  (:init
    (alive protagonist)
    (at protagonist dorm-room)
    (intends protagonist (alive protagonist))
    (intends protagonist (anchored spark))
    (intends protagonist (in-box spark lightbox1))
    (intends protagonist (has-energy spark))
    (intends protagonist (has-mirror lightbox1 mirror1))
    (intends protagonist (has-button lightbox1))
    (intends protagonist (open lightbox1))
    (intends protagonist (not (in-box spark lightbox1)))
    (intends protagonist (shines spark))
    (intends protagonist (not (has-energy spark)))
    (intends protagonist (not (open lightbox1)))
    (intends protagonist (not (has-mirror lightbox1 mirror1)))