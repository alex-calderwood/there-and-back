(define (problem internet-outage)
  (:domain
    internet-outage)
  (:objects
    protagonist husband neighbor1 neighbor2 neighbor3 neighbor4 bus-driver coworker - character
    home outside - place
    phone tv - device)
  (:init
    (at protagonist home)
    (at husband home)
    (at neighbor1 home)
    (at neighbor2 home)
    (at neighbor3 home)
    (at neighbor4 home)
    (at bus-driver outside)
    (at coworker outside)
    (has-device protagonist phone)
    (has-device protagonist tv)
    (electricity home)
    (intends protagonist (awake protagonist))
    (intends protagonist (wearing-clothes protagonist))
    (intends protagonist (device-connected phone))
    (intends protagonist (device-connected tv))
    (intends protagonist (at protagonist outside))
    (intends protagonist (school-canceled))
  )
  (:goal
    (and (awake protagonist)
    (wearing-clothes protagonist)
    (at protagonist outside)
    (school-canceled))
  )
)