#lang racket

(define max_clients 20)
(define actualClients 0)

(define tmpClients (make-vector 0))

(define clients (make-vector 0))

(define (attachClient client_id)
    
    
    
        
        (set! actualClients (vector-length clients))
        
        (set! tmpClients clients)
        
        ;(print tmpClients)
        
        (set! clients (make-vector (+ 1 actualClients)))
        
        
        (for ([i actualClients])
            
            (vector-set! clients i (vector-ref tmpClients i))
            
            ;(if (= i (- actualClients 1))
                    ;        (print 'ultimo)
                    ;        (print i)                   
            ;)

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
            
;;;;;        (vector-set! clients i (vector-ref tmpClients i))
;            (print i)
;            (print actualClients)
;            (newline)
;            
;            (print (vector-ref tmpClients i))
;            (newline)
            
                    
            
            (if (equal? client_id (vector-ref tmpClients i))
                            (set! detached #t)
                            
                            (assignSlot client_id i)
                                        
            )

        )
  
  
  
)



(attachClient 'uno)
(attachClient 'due)
(attachClient 'tre)

;(detachClient 'due)

