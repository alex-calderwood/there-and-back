(define (plan irish-assassination-solution)
  (:problem irish-assassination)
  (:steps (retrieve visitor webley protagonist-home)
          (travel visitor protagonist-home church)
          (kill visitor webley informant2 church)
          (kill visitor webley informant1 church)))