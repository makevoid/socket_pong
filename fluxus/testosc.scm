(osc-source "6543")

(define max_clients 20)
(define actualClients 0)

(define tmpClients (make-vector 0))

(define Shape (with-state (build-cube)))
(with-primitive Shape (hide 1))

(define clients (make-vector 0))


(define (phone2cube X Y Z)
    
    (with-state
        (colour (vector (abs (* 0.1 X)) (abs(* 0.1 Y)) (abs (* 0.1 Z))))
        (rotate (vector X Y Z))
        (draw-instance Shape)
    )

)


(define (testFor)

	(for ([j 10])

		;(print j)

		(if (>= j 8)

			(print "sforato")
			
			(print j)
		
		)

	)

)



(define (attachClient client_id)
    
    
    
        
        (set! actualClients (vector-length clients))
        
        (set! tmpClients clients)
        
        (set! clients (make-vector (+ 1 actualClients)))
        
        
        (for ([i actualClients])
            
            (vector-set! clients i (vector-ref tmpClients i))

        )
        
        
        (vector-set! clients actualClients client_id)

)



(define (detachClient client_id)

  (set! actualClients (vector-length clients))
  
  (set! tmpClients clients)
  
  (set! clients (make-vector (- actualClients 1)))
  
  (define detached #f)
  (define j #f)
  
  (define (assignSlot client_id index)
    
      (if (not detached)
          (set! j index)
          (set! j (- index 1))
      )
    
      (vector-set! clients j (vector-ref tmpClients index))  
    
  )
  
  
          (for ([i actualClients])
            
            (if (equal? client_id (vector-ref tmpClients i))
                            (set! detached #t)
                            
                            (assignSlot client_id i)
                                        
            )

        )
  
  
  
)


(define (clients2cubes client_id X Y Z)
    
    (define counter 0)
    
    ;(for ([i clients])
            
            (with-state
            	(translate (vector (random 4) (random 4) (random 4)))
                (rotate (vector X Y Z))
                (draw-instance Shape)
            )
            
            
            
    ;)
    
    
    (if (member client_id (vector->list clients))
    	(set! counter 0)
	(attachClient client_id)
    )
    
)


(every-frame
    (with-state
        (when (osc-msg "/oscAddress")
             (begin (display (osc 0)) (newline))
             (begin (display (osc 1)) (newline))
             (begin (display (osc 2)) (newline))
        )
        
        
        ; utilizzare parametro OSC 0 per assegnare id_client
        (when (osc-msg "/oscAddressMulti")
        
            ;(phone2cube (osc 1) (osc 2) (osc 3))
            
            (clients2cubes (osc 0) (osc 1) (osc 2) (osc 3))
            
            ;(begin (display (osc 0)) (newline) (display "X:") (display (osc 1)) (display "Y:") (display (osc 2)) (display "Z:")(display (osc 3)) (newline))
        
        )
        
        
;        (when (osc-msg "/detachClient")
;            ; Passare come unico parametro osc l'id del client socket.id
;            ;(detachClient (osc 0))
;        )
    )
)
