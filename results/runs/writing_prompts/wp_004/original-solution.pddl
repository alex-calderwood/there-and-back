(define (plan earth-reentry-solution)
  (:problem earth-reentry)
  (:steps (enter-airlock soldier3)
          (pressurize-suit soldier3)
          (jump soldier3 earth)
          (activate-wingsuit soldier3)
          (land soldier3 earth)
          (enter-airlock soldier2)
          (pressurize-suit soldier2)
          (jump soldier2 earth)
          (activate-wingsuit soldier2)
          (land soldier2 earth)
          (enter-airlock soldier1)
          (pressurize-suit soldier1)
          (jump soldier1 earth)
          (activate-wingsuit soldier1)
          (land soldier1 earth)
          (enter-airlock squad-leader)
          (pressurize-suit squad-leader)
          (jump squad-leader earth)
          (activate-wingsuit squad-leader)
          (land squad-leader earth)))