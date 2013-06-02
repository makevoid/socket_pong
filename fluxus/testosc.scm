(osc-source "6543")

(define max_clients 20)
(define actualClients 0)

(define clients (make-vector 0))
(define tmpClients (make-vector 0))
(define activeClients (make-vector 0))
(define tmpActive (make-vector 0))

(define Shape (with-state (build-cube)))
(with-primitive Shape (hide 1))

(define oscID #f)
(define oscX 0)
(define oscY 0)
(define oscZ 0)



;;; TESTING VARS
;;;(define c1 'A)
;;;(define c2 'B)
;;;(define c3 'C)


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


(define (startClients client_id X Y Z)

	(if (equal? client_id #f)
		(set! oscID #f)
		(clientsDemux client_id X Y Z)
	)

)

(define (clientsDemux client_id X Y Z)
	
	
	
	(define countActive 0)
	
	; Attach client if not registered
	(if (member client_id (vector->list clients))
		(set! countActive (vector-length clients))
		(attachClient client_id)
	)
	
	(set! countActive (vector-length clients))
	
	; Salvo gli attivi attuali in un vettore temporaneo
	(set! tmpActive activeClients)
	
	; svuoto il vettore degli attivi e lo imposto alla lunghezza dei clients
	(set! activeClients (make-vector (vector-length clients)))
	
	; Riassegno le coordinate ad ogni client come vettore di valori in activeClients
	(for ([i countActive])
		(if (equal? client_id (vector-ref clients i))
			(vector-set! activeClients i (vector (vector-ref clients i) X Y Z))
			(vector-set! activeClients i (vector-ref tmpActive i))
		)
		
	)
	

	(define transDelta 0)

	; Disegno ogni client con le proprie coordinate
	(for ([i countActive])
		
		;(begin (display i))
		
		;per il momento evitiamo la sovrapposizione con un delta
		
		(set! transDelta i)
		(with-state
			(translate (vector transDelta 0 0))
			(drawShape
				(vector-ref (vector-ref activeClients i) 1)
				(vector-ref (vector-ref activeClients i) 2)
				(vector-ref (vector-ref activeClients i) 3)
			)
		)
		
	)
	
)

(define (drawShape X Y Z)
		
		
;;;;;	(define (drawSimple)
;;;;;	    (with-state
;;;;;                (draw-instance Shape)
;;;;;            )
;;;;;	)
;;;;;	
;;;;;	
;;;;;	(define (drawModified)
;;;;;            (with-state
;;;;;                (rotate (vector X Y Z))
;;;;;                (draw-instance Shape)
;;;;;            )
;;;;;	)
;;;;;	
;;;;;	
;;;;;	(for ([i clients])
;;;;;		(if (equal? client_id (vector-ref clients i))
;;;;;			(drawModified)
;;;;;			(drawSimple)
;;;;;		)
;;;;;	)	
	
            (with-state
                (rotate (vector X Y Z))
                
                (colour (vector (abs (* 0.05 X)) (abs(* 0.05 Y)) (abs (* 0.05 Z))))
                (draw-instance Shape)
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
        ;(when (osc-msg "/oscAddressMulti")
        ;     (begin (display (osc 0)) (newline))
        ;     (begin (display (osc 1)) (newline))
        ;     (begin (display (osc 2)) (newline))
        ;)
        
        
        ; utilizzare parametro OSC 0 per assegnare id_client
        ;(when (osc-msg "/oscAddressMulti")
        
            ;(phone2cube (osc 1) (osc 2) (osc 3))
            
            ;(clients2cubes (osc 0) (osc 1) (osc 2) (osc 3))
            
            ;(clientsDemux (osc 0) (osc 1) (osc 2) (osc 3))
            
            ;(begin (display (osc 0)) (newline) (display "X:") (display (osc 1)) (display "Y:") (display (osc 2)) (display "Z:")(display (osc 3)) (newline))
        
        ;)
        
	  (when (osc-msg "/detachClient")
	      ; Passare come unico parametro osc l'id del client socket.id

		(begin (display (osc 0)) (newline))
		(detachClient (osc 0))
	  )    


	(when (osc-msg "/oscAddressMulti")
		(set! oscID (osc 0))
		(set! oscX (osc 1))
		(set! oscY (osc 2))
		(set! oscZ (osc 3))
	)

	
	(startClients oscID oscX oscY oscZ)
	;(phone2cube oscX oscY oscZ)

  )
)
