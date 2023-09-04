(define (problem matrix-glitch)
  (:domain matrix-glitch)
  (:objects
    jennah mila - person)
  (:init
    (naked jennah)
    (naked mila)
    (not (stuck jennah))
    (not (stuck mila))
    (not (fallen jennah))
    (not (fallen mila))
    (not (digging jennah))
    (not (digging mila))
    (not (helping jennah))
    (not (helping mila))
    (not (panicked jennah))
    (not (panicked mila))
    (not (crying jennah))
    (not (crying mila))
    (not (chanted jennah))
    (not (chanted mila))
    (not (bearded jennah))
    (not (bearded mila))
    (intends jennah (feel-glitch))
    (intends mila (feel-glitch))
    (intends jennah (slapped mila))
    (intends jennah (panic jennah))
    (intends mila (cry mila))
    (intends jennah (help jennah jennah))
    (intends jennah (help jennah mila))
    (intends mil