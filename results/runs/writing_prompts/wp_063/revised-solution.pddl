(define (plan death-calculator-problem-solution)
  (:problem death-calculator-problem)
  (:steps (call-police pat)
          (follow-officer pat protagonist)
          (avert-death pat)
          (follow-officer stephen protagonist)
          (call-police stephen)
          (avert-death stephen)
          (follow-officer protagonist protagonist)
          (call-police protagonist)
          (avert-death protagonist)))