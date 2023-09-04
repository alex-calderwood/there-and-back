(define (problem shelby-frost-adventure)
  (:domain
    shelby-frost)
  (:objects
    shelby frost - character
    pub - object
    creature - creature)
  (:init
    (at shelby pub)
    (at frost pub)
    (alive shelby)
    (alive frost)
    (unwell shelby)
    (creature-attack creature)
    (frozen shelby)
    (intends frost (owe shelby frost))
    (intends frost (transformed frost))
    (intends frost (not (frozen shelby))))
  (:goal
    (and (owe shelby frost)
    (transformed frost)
    (not (frozen shelby))))
)