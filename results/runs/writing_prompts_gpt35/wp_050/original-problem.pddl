(define (problem rebellion-end)
  (:domain rebellion)
  (:objects
    princess knight1 knight2 - character
    gallows castle - object)
  (:init
    (alive princess)
    (loyal-to-crown princess)
    (at princess castle)
    (intends princess (not (alive princess)))
    (alive knight1)
    (loyal-to-crown knight1)
    (at knight1 castle)
    (intends knight1 (protects knight1 princess castle))
    (intends knight1 (not (alive knight1)))
    (alive knight2)
    (loyal-to-rebellion knight2)
    (at knight2 castle)
    (intends knight2 (not (alive knight2)))
    (intends knight2 (execute-shielded princess knight1 gallows))
    (intends knight2 (execute knight1 gallows))
    (intends knight2 (execute princess gallows)))
  (:goal
    (and (not (alive princess))
    (executed princess)
    (not (alive knight1))
    (executed knight1)
    (not (alive knight2))
    (executed knight2)))
)