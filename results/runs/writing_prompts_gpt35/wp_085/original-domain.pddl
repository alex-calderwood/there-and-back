(define (domain internet-outage)
  (:requirements :strips :negative-preconditions :typing :equality)
  (:types person - object)
  (:predicates
    (connected ?person - person)
    (has-power)
    (has-internet)
    (has-tv)
    (has-electricity)
    (has-phone)
    (has-service)
    (has-wifi)
    (upset ?person - person)
    (cancelled-school)
    (at-school ?person - person)
    (at-home ?person - person)
    (at-work ?person - person)
    (at ?person - person ?location - object)
  )

  ;; A person travels from one location to another.
  (:action travel
    :parameters
      (?person - person ?from - object ?to - object)
    :precondition
      (and (not (= ?from ?to))
      (at ?person ?from))
    :effect
      (and (not (at ?person ?from))
      (at ?person ?to))
  )

  ;; The internet goes out.
  (:action internet-out
    :precondition
      (and (has-power)
      (has-internet))
    :effect
      (and (not (has-internet))
      (not (has-wifi))
      (not (has-service)))
  )

  ;; The internet comes back on.
  (:action internet-on
    :precondition
      (and (has-power)
      (not (has-internet)))
    :effect
      (and (has-internet)
      (has-wifi)
      (has-service))
  )

  ;; The power goes out.
  (:action power-out
    :precondition
      (has-power)
    :effect
      (not (has-power))
  )

  ;; The power comes back on.
  (:action power-on
    :precondition
      (not (has-power))
    :effect
      (has-power)
  )

  ;; The TV goes out.
  (:action tv-out
    :precondition
      (and (has-power)
      (has-tv))
    :effect
      (not (has-tv))
  )

  ;; The TV comes back on.
  (:action tv-on
    :precondition
      (and (has-power)
      (not (has-tv)))
    :effect
      (has-tv)
  )

  ;; The phone goes out.
  (:action phone-out
    :precondition
      (and (has-power)
      (has-phone))
    :effect
      (not (has-phone))
  )

  ;; The phone comes back on.
  (:action phone-on
    :precondition
      (and (has-power)
      (not (has-phone)))
    :effect
      (has-phone)
  )

  ;; A person becomes upset.
  (:action upset
    :parameters
      (?person - person)
    :precondition
      (and (has-power)
      (at ?person ?location))
    :effect
      (upset ?person)
  )

  ;; School is cancelled.
  (:action cancel-school
    :precondition
      (and (has-power)
      (at-school ?person))
    :effect
      (cancelled-school)
  )
)