;;; -*- syntax: Lisp; font-size: 16; line-numbers: no; -*-


;; (A nice title for this experiment could be "um + todos")
;; one+robot


;; =============================================================
;; ============== Aux functions ================================
;; -------------- Flatten, number, binary and string conv. -----

(define (flatten x)
  "Flatten a nested list. E.g.: (flatten '((1 2) (3 (4))))
   => (1 2 3 4)"
    (cond ((null? x) '())
          ((not (pair? x)) (list x))
          (else (append (flatten (car x))
                        (flatten (cdr x))))))

;; I probably copied flatten from somewhere else on the
;; internet 

;; --------------- String to list conv. -------------------------

;; In scheme s7 decimal to binary conversion is done by using
;; the function number->string. So I'm forced
;; to convert to binary *and* to string at the same time. 

(number->string 6 2) ; Decimal 6 in binary is "110".

;; To convert back to number the output of number->string
;; I would need to use string->number.

(string->number "120") 

;; But what I really need is to have each digit separated in a 
;; list. E.g.: (1 2 0) instead of '120.
;; This can be done by string->list which converts a string into a
;; *list of characters*.

(string->list "120") ; Returns (#\1 #\2 #\0).

;; To obtain a list of integers from string->list
;; I need to convert each caracter to a string and
;; finally convert each ensuing string to a number.
;; The code below converts 33 into the binary list 
;; (1 0 0 0 0 1)


(let* ((num->bin-list 33)
       (num->bin-list (number->string num->bin-list 2))
       (num->bin-list (string->list num->bin-list))
       (num->bin-list (map string num->bin-list))
       (num->bin-list (map string->number num->bin-list)))
  num->bin-list)


;; Or more concisely :

(map string->number
     (map string
      (string->list
       (number->string 33 2))))

;; =======================================================
;; ------------------Pitch Array -------------------------

;; The procedure 'pitch array' is a very crude way of 
;; creating random chords or pitch-sets with a minimum
;; of control. I created this procedure because as one
;; plus one is a 'rhythm only' piece it would be interesting
;; to have some kind of pitch coloration for tests and
;; variety. It is not about expanding the composition
;; exactly but more about adding colour to performance, 
;; like an arrangement to a pitched percussion, like
;; bells or ringing rocks. 

(define* (pitch-array (density 4) (unity 1))
"Returns a random list of pitches whose length is given by 
the parameter density and whose consecutive intervals
is of size 'unity'. E.g.: (pitch-array 6 2)
=> (41 43 45 47 49 51)"
  (loop for i from 1 to density
        with range-bottom = 36
        with range-top = 103
        with fund-top = (- (- range-top (* density unity)) range-bottom)
        with fund = (+ range-bottom (random fund-top))
        collect (+ fund (* i unity))))


; range, especially bottom should be a parameter.

(pitch-array 6 2)

;; =======================================================
;; ------------------- Additive Rhythmic Pattern ---------
;; ------------------- Sequence A and C (reverse) --------


;; 1 + 1 is a piece built around two rhythmic units,
;; as Philip Glass himself says. The first cell consists of 
;; two sixteenths and one eighth. The other cell consists 
;; of a single eighth note.
;;
;; For me what is most important, at least in terms of 
;; algorithmical thinking, is how these two cells are combined,
;; cells that, by the way, could be something else. 
;; Glass talks of "continuous arithmetic progressions".
;; Of the three examples of realization he gives, the first one, 
;; and by extension all three, can be easily modelled by different 
;; arithmetic formulae. 
;;
;; For instance, If we replace the cells, in the first example, 
;; as in a sequence of indexes, we would obtain sequence A023532,
;; wich in turn can be modeled by the formula 
;; a(n) = 0 if and only if 8n+9 is a square.
;;
;; So to reproduce this sequence of indexes, and then apply it 
;; to Glass original rythmic units or to whatever material we should
;; implement the above formula, starting by defining a bolean function
;; to determine if a given number has an integer square.

(define (issquare? n) 
"Returns true if it has an integer root. 
E.g.: (issquare? 2) => #f, (issquare? 9) => #t"
  (integer? (sqrt n)))

(define (a-seq n)
"a(n) = 0 if and only if 8n+9 is a square (A023532).
E.g.: (map a-seq '(0 1 2 3 4 5 6 7 8 9))."
  (if (issquare? (+ 9 (* 8 n)))
      0
      1))

(define (c-seq n)
"The same as a-seq, but with 0's and 1's flipped.
E.g.: (1 0 1 0 0 1 0 0 0 1)."
  (- 1 (a-seq n)))

;; -----------------------------------------------------------
;; --------------------------- Cells A and B -----------------

;; My idea of how to model the two basic rhythmic 'units' of 1+1,
;; in order to reproduce the original cells but also generate 
;; automatic, deterministic variations, is to to convert integer 
;; numbers to their respective binary representations. 
;;
;; When I did that to model Reich's Clapping Music the resulting zero's 
;; were conveniently mapped to rests and the one's to beats. 
;; As in Clapping everything is either eighth notes or eighth rests
;; (it's really a kind of note-on/note-off thing, 
;; something very 'binary' in nature), I would dare to say that it
;; worked really well. 
;;
;; Now, in the case of the model for this Philip Glass piece, 
;; the metaphor is different, the binary dichotomy consists of
;; short duration versus long duration. 
;;
;; So if we take the number 10 and convert it to binary we have
;; 1, 0, 1, 0 which in one model would correspond to an alternation
;; of note-on's and note-off's, two times, and in the model we want
;; now would correspond to an alternation of long and short durations.
;;
;; The main function is defined in the a-cell routine.

(define (a-cell dec)
"Take an integer number and return a list of zeros and ones.
E.g. (a-cell 6) => (1 0 1 0)"
  (map string->number
     (map string
      (string->list
       (number->string dec 2)))))

;; Now to calculate the b-cell, for the time being I'm simply 
;; calculating the a-cell first and taking its output's last 
;; digit, which is one of the relations we can see in Glass
;; score. Maybe this is too crude. Another way of doing it 
;; is to think of the b-cell as a a-cell with another 
;; integer number as input. 
;; 
;; I wouldn't like to do that way because, for me,
;; at least in example 1 of the score, b-cell
;; is a kind of one single figure that disrupts the a-cell
;; characteristic rhythm. It is like a way to break the flow 
;; or embelish what a-cell does most of the time.  
;;
;; In the other examples, inversely, b-cell is a pulse which
;; a-cell embelish. In other for these examples to work, one
;; of the two cells need to be a single rhytmic figure or pulse. 

(define (b-cell dec)
"Calculates the binary representation of dec and returns
its last digit. E.g.: (b-cell 6) => 0. (compare with
(a-cell 6) which returns (1 1 0). "
  (last (a-cell dec)))

;; -----------------------------------------------------------
;; ------------------- Test Function: beat<-cell -------------


;; In the end, the model we want to build is iterative, 
;; in the style that is conventionally called "real time" 
;; (I'm thinking of PD and Max software). 
;; Unlike "Clapping Music", Philip Glass provides an 'algorithm' that
;; can 'run' until the interpreter feels like it or finds it 
;; appropriate to stop. I believe the interpreter is also free to 
;; alter some aspects institively during the course of the performance.
;;
;; Although we could calculate the piece in a deferred time, 
;; choosing an a priori maximum "n" and a series (or curve) of values
;; for each eventual parameter, we will build instead a program that 
;; "n" is provided on the fly. 
;;
;; Below I start doing that to generate a-cells cyclically, where 
;; for each sucessive n (the nth beat) the function outputs 
;; the equivalent of either a long or short duration.  
;;
;; This is achieved by calculating mod indexes for the
;; a-cell. 

(define (beat<-cell dec beat)
  (let* ((cell (a-cell dec))
         (len (length cell)))
    (nth cell (mod beat len))))

(map 
 (lambda (x) (format #f "Beat #~a, value ~a~%" x (beat<-cell 6 x)))
 '(0 1 2 3 4 5 6))

;; ------------------------------------------------------------
;; -------------------------- Aux Function: Iota --------------
                                                             
(define (iota n)                                            
"Iverson's iota function. Zero based.                        
E.g.: (iota 5) => (0 1 2 3 4)"                               
  (loop for i from 0 below n                                 
        collect i))                                          
;; ------------------------------------------------------------
;; ------------------------- Beat<-seq ------------------------

;; Here is one of the model's main functions. 
;; It calculates cells A and B, and combines them based on sequence A. 
;; What's particular about this function is that it always computes 
;; the output for several beats at once. How much is computed 
;; beforehand is roughly determined by 'cycles' (which is the
;; number of combinations to be calculated after 'cycling' them).  
;; The actual beat 'n' plugged into the input is approached
;; with modular arithmetics.     

(define (beat<-seq dec cycles beat)
"Converts dec into two arrays of binary numbers,
iteratively combining them according to beat and A023532. 
Pattern is restarted after 'cycles' combinations are made.
E.g.: (map (lambda (x) (beat<-seq 6 10 x)) (iota 10))
=> (1 1 0 0 1 1 0 0 0 1)."
  (let* ((a (a-cell dec))
         (b (b-cell dec))
         (ab (list a b))
         (cell-seq (map a-seq (iota cycles)))
         (select (lambda (x) (nth ab x)))
         (seq (map select cell-seq))
         (seq (flatten seq))
         (seq-len (length seq))
         (take-beat (lambda (x y z) (nth z (mod x y)))))
    (take-beat beat seq-len seq)))

;; ----------------------------------------------------------------
;; ----------------------------- Bin->Dur -------------------------

(define (bin->dur bin a b)
"Maps zero to input a and one to input b.
E.g.: (bin->dur 1 :short :long) => :long"
  (if (= bin 0) a b))

;; ----------------------------------------------------------------
;; ------------------------------ One + One -----------------------

(define* (one-plus-one (dec 5) (mul '2) (vel '.7) (chan '0) (pitches ''(48 59 66)))
  (process for i from 0
           with cycles = 20
           with chord
           with curr-mul
           with curr-vel
           do (set! chord (eval pitches))
           do (set! curr-mul (eval mul))
           do (set! curr-vel (eval vel))
           do (set! curr-chan (eval chan))
           do (loop for k in chord 
                    do (mp:midi :key k :dur .09 :amp curr-vel :chan curr-chan))
           (wait (bin->dur (beat<-seq dec cycles i) (* 0.08 curr-mul) (* 0.15 curr-mul)))))


(sprout (one-plus-one))

(list 
 (define ch1 (pitch-array :density 10 :unity 5))
 (define ch2 (pitch-array :density 1 :unity 2))
 (define ch3 (pitch-array :density 11 :unity 7))
 (define ch4 (pitch-array :density 4 :unity 7))
 (define ch5 (pitch-array :density 5 :unity 7))
 (define ch6 (pitch-array :density 1 :unity 1)))

ch1

(list (sprout (one-plus-one :dec 8 :mul 5 :vel .9 :chan 0 :pitches 'ch1) (sync 1) :id 1)  
      (sprout (one-plus-one :dec 3 :mul 2.9 :vel 1 :chan 1 :pitches 'ch2) (sync 1) :id 2)
      (sprout (one-plus-one :dec 13 :mul 3.5 :vel 1 :chan 2 :pitches 'ch3) (sync 1) :id 3)
      (sprout (one-plus-one :dec 9 :mul 3 :vel 1 :chan 3 :pitches 'ch4) (sync 1) :id 4)
      (sprout (one-plus-one :dec 13 :mul 5 :vel 1 :chan 4 :pitches 'ch5) (sync 1) :id 5)
      (sprout (one-plus-one :dec 11 :mul 6 :vel 1 :chan 5 :pitches 'ch6) (sync 1) :id 6))

(stop 1)

;; -------------------- MIDI input -------------------------------------
;; -------------------- Test function: mprinter ------------------------

(define (mprinter data)
"Simple function which prints incoming midi messages.
To use with mp:receive: (mp:receive mprinter)."
  (print data))

(mp:receive mprinter)
(mp:receive #f)

;; --------------------- Test function: mstart --------------------------

(define start-counter 0)
(define spr-proc (lambda () (one-plus-one)))

(define (mstart data)
"This function sprouts a process (hardcoded) when a particular 
note (hardcoded) is received."
  (let ((keyn (third data)))
    (if (= keyn 36)
      (begin (if (= (mod start-counter 2) 0)
               (sprout (spr-proc) :id 1)
               (stop 1))
             (set! start-counter (1+ start-counter))))))

(mp:receive mm:on mstart)
(mp:receive #f)

;; ----------------------- Test function: mstart-ctrl ---------------------

(define start-counter 0)
(define vel-counter 0.7)
(define mul-counter 2)
(define chan-buffer 0)

(define density-buffer 3)
(define unity-buffer 7)
(define parray (pitch-array :density density-buffer :unity unity-buffer))

(set! spr-proc 
      (lambda () (one-plus-one :vel 'vel-counter 
                               :mul 'mul-counter 
                               :chan 'chan-buffer
                               :pitches 'parray)))

(define (mctrl data)
"Binds midi keys to velocity and mult global vars."
  (let ((keyn (third data)))
    (cond ((= keyn 37) (if (> vel-counter 0.4) (set! vel-counter (- vel-counter .1))))
          ((= keyn 38) (if (< vel-counter 0.9) (set! vel-counter (+ vel-counter .1))))
          ((= keyn 39) (if (> mul-counter .1) (set! mul-counter (- mul-counter .1))))
          ((= keyn 40) (if (< mul-counter 4) (set! mul-counter (+ mul-counter .1)))))))

(define (mchan data)
"Binds midi keys to channel global vars."
  (let ((keyn (third data)))
    (cond ((= keyn 41) (set! chan-buffer 0))
          ((= keyn 42) (set! chan-buffer 1))
          ((= keyn 43) (set! chan-buffer 2))
          ((= keyn 44) (set! chan-buffer 3)))))

(define (mp-array data)
  (let ((keyn (third data)))
    (cond ((= keyn 45) (begin (if (> density-buffer 3) 
                                (set! density-buffer (1- density-buffer)))
                              (set! parray (pitch-array density-buffer unity-buffer))))
           ((= keyn 46) (begin (if (< density-buffer 11)
                                 (set! density-buffer (1+ density-buffer)))
                               (set! parray (pitch-array density-buffer unity-buffer))))
           ((= keyn 47) (begin (set! unity-buffer 3.5)
                               (set! parray (pitch-array density-buffer unity-buffer))))
           ((= keyn 48) (begin (set! unity-buffer 7)
                               (set! parray (pitch-array density-buffer unity-buffer)))) 
           ((= keyn 49) (begin (set! unity-buffer 1.5)
                               (set! parray (pitch-array density-buffer unity-buffer)))))))

(define (mstart-xylo data)
  (let ((keyn (third data)))
    (if (= keyn 50)
      (sprout (one-plus-one :dec 3 
                            :mul 2.9
                            :vel .8 
                            :chan 1 
                            :pitches 'ch2) (sync 1) :id 2))
    (if (= keyn 51)
      (stop 2))))

(define (mstart-ctrl data) 
  (begin (mstart data) 
         (mctrl data)
         (mchan data)
         (mp-array data)
         (mstart-xylo data)))

(mp:receive mm:on mstart-ctrl)
(mp:receive #f)

vel-counter
mul-counter
density-buffer

(1- 4)
          
(begin 4 5)
