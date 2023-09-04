(define (problem new-granada-reconquest)
  (:domain
    new-granada-empire)
  (:objects
    akarim - character
    granada new-granada morocco portugal castile aragon - nation
    caribbean americas - object)
  (:init
    (alive akarim)
    (ruler akarim granada)
    (capital granada morocco)
    (capital new-granada caribbean)
    (at-war granada portugal)
    (at-war granada castile)
    (at-war granada aragon)
    (settled granada americas)
    (built akarim ships americas)
    (built akarim new-granada caribbean)
    (navy-defeated granada portugal)
    (trading granada)
    (plantation granada americas)
    (farm-estate granada americas)
    (slave-trade granada))
  (:goal
    (and (ruler akarim new-granada)
    (capital new-granada caribbean)
    (navy-defeated granada portugal)
    (trading granada)
    (plantation granada americas)
    (farm-estate granada americas)
    (slave-trade granada)))
)