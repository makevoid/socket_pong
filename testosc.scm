(osc-source "6543")
(every-frame
    (with-state
        (when (osc-msg "/oscAddress")
             (begin (display (osc-msg)) (newline))

        )

    ))