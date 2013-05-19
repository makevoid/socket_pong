(osc-source "6543")

(define max_clients 20)
(define actualClients 0)

(define tmpClients (vector 0))

(define Shape (build-cube))

(define clients (vector 0))


(define (phone2cube X Y Z)
    
    (with-state
        (colour (vector (abs (* 0.1 X)) (abs(* 0.1 Y)) (abs (* 0.1 Z))))
        (rotate (vector X Y Z))
        (draw-instance Shape)
    )

)


;(define (assignClient client_id)

;;;;;;;;;;> (length (list "hop" "skip" "jump"))        ; count the elements

;;;;;;;;;;3
;;;;;;;;;;> (list-ref (list "hop" "skip" "jump") 0)    ; extract by position

;;;;;;;;;;"hop"
;;;;;;;;;;> (list-ref (list "hop" "skip" "jump") 1)

;;;;;;;;;;"skip"
;;;;;;;;;;> (append (list "hop" "skip") (list "jump")) ; combine lists

;;;;;;;;;;'("hop" "skip" "jump")
;;;;;;;;;;> (reverse (list "hop" "skip" "jump"))       ; reverse order

;;;;;;;;;;'("jump" "skip" "hop")
;;;;;;;;;;> (member "fall" (list "hop" "skip" "jump")) ; check for an element

;;;;;;;;;;#f

;;if clients.length >= max_clients return false

;;if client_id in_array clients return false

;;else
;;clients[clients.length+1] = client_id

;)


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
	
	
	
	;(if (member client_id clients)
		;;;;;Per vector-append serve racket/vectors e non è detto che funzioni
		;;;;;(vector-append clients (vector client_id))
		;add client_id to clients
		
		(set! actualClients (vector-length clients))
		
		(set! tmpClients clients)
		
		;(print tmpClients)
		
		(set! clients (make-vector (+ 1 actualClients)))
		
		
		(for ([i actualClients])
			
			(vector-set! clients i (vector-ref tmpClients i))
;			(print i)
;			(print actualClients)
;			(newline)
;			
;			(print (vector-ref tmpClients i))
;			(newline)
			
			(if (< i actualClients)
				
				(print i);(vector-set! clients i (vector-ref tmpClients i))
				
				(print "ultimo");(vector-set! clients i client_id)
						
			)

			;(vector-set! clients i client_id)
			;(set! clients (build-vector actualClients (vector-ref clients i)))
			;(vector-set! clients actualClients client_id)
		)
		
		
		(vector-set! clients actualClients client_id)
		
		
	;)

)


;(define (detachClient client_id)

;    ;remove client_id from clients

;)


(define (clients2cubes client_id X Y Z)

	;NO! ANDREBBE TROVATO IL MODO DI NON ITERARE clients AD OGNI CICLO
    (for ([i clients])
        
;;        (if (>= max_clients (vector-length clients))
;;        	
;;        	#f
;;        
;;        )
        
;;        (if (member client_id clients)
;;        )
            
;;            (define activeClient (vector-ref clients i))
            
            
            (begin (display i))
            
            (with-state
            	(translate (vector i i i))
                (rotate (vector X Y Z))
                (draw-instance Shape)
            )
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
        
            (phone2cube (osc 1) (osc 2) (osc 3))
            (begin (display (osc 0)) (newline) (display "X:") (display (osc 1)) (display "Y:") (display (osc 2)) (display "Z:")(display (osc 3)) (newline))
        ;(clients2cubes (osc 0) (osc 1) (osc 2) (osc 3))
        )
        
        
;        (when (osc-msg "/detachClient")
;            ; Passare come unico parametro osc l'id del client socket.id
;            ;(detachClient (osc 0))
;        )
    )
)
