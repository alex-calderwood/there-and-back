;;;
;;; A problem for felling the story of Aladdin from 1001 Nights
;;; Created by Mark O. Riedl for his dissertation
;;; Ported to PDDL 3 by Stephen G. Ware
;;;
(define (problem aladdin-cave)
  (:domain aladdin)
  (:objects hero - knight
            king - king
            jasmine - female
            dragon - dragon
            genie - genie
            castle mountain - place
            lamp - magic-lamp)
  (:init (alive hero) (single hero) (at hero castle) (loyal-to hero king)
         (alive king) (single king) (at king castle)
         (alive jasmine) (beautiful jasmine) (single jasmine) (at jasmine castle) 
         (alive dragon) (scary dragon) (at dragon mountain) (has dragon lamp)
         (alive genie) (scary genie) (confined genie) (in genie lamp))
  (:goal (and (not (alive genie))
              (married-to king jasmine))))