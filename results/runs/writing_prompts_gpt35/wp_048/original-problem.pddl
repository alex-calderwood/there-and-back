(define (problem rebirth)
  (:domain death-and-rebirth)
  (:objects
    person1 person2 person3 - person)
  (:init
    (alive person1)
    (alive person2)
    (alive person3)
    (intends death (alive person1))
    (intends death (alive person2))
    (intends death (alive person3))
    (intends person1 (eq ?x (choose-task person1 (or (in-pain person1) (completed-blood person1) (completed-sweat person1) (completed-tears person1))))))
    (intends person2 (eq ?x (choose-task person2 (or (in-pain person2) (completed-blood person2) (completed-sweat person2) (completed-tears person2))))))
    (intends person3 (eq ?x (choose-task person3 (or (in-pain person3) (completed-blood person3) (completed-sweat person3) (completed-tears person3)))))))
  (:goal
    (and (not (alive death))
    (or (and (completed-blood person1) (not (in-pain person1)))
    (and (completed-sweat person2) (not (in-pain person2)))
    (and (completed-tears person3) (collapsed person3))))))