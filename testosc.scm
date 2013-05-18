(osc-source "6543")

(define max_clients 10)
(define Shape (build-cube))

;(define clients (vector)))


(define (phone2cube X Y Z)
	
	;(with-state
		(rotate (vector X Y Z))
		(draw-instance Shape)
	;)

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




;(define (detachClient client_id)

;	;remove client_id from clients

;)


;(define (clients2cubes client_id X Y Z)

;;NO! ANDREBBE TROVATO IL MODO DI NON ITERARE clients AD OGNI CICLO
;;	(for ([i clients])	
;;    		
;;		(if (member client_id clients)
;;			(with-state
;;				(rotate (vector X Y Z))
;;				(draw-instance Shape)
;;			)
;;			
;;		)
;;    	)

;)


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
;        	; Passare come unico parametro osc l'id del client socket.id
;        	;(detachClient (osc 0))
;        )
    )
)
