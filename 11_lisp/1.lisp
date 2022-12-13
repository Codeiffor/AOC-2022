(defparameter monkeys (make-array '0 :adjustable t :fill-pointer t))

(setf monkey (make-array '7 :initial-element :unset))

(defun update_monkey ()
  (vector-push-extend monkey monkeys)
  (setf monkey (make-array '7 :initial-element :unset)))

(defun parse-list (s)
  (setf l '())
  (loop for n = (position #\, s)
    while n do
      (setf l (cons (parse-integer (substring s 0 n)) l))
      (setf s (substring s (+ n 2)))
      )
  (setf l (cons (parse-integer s) l))
  (reverse l))

(defun parse (line c)
  (if (= 0 (mod c 7))
    (setf (aref monkey 0) (parse-integer (substring line 7 (- (length line) 1)))))
  (if (= 1 (mod c 7))
    (setf (aref monkey 1) (parse-list (substring line 18))))
    ;; (parse-list (substring line 18)))
  (if (= 2 (mod c 7))
    (if (and (= 28 (length line)) (string= "old" (substring line 25)) )
      (setf (aref monkey 2) "^")
      (progn
        (setf (aref monkey 2) (substring line 23 24))
        (setf (aref monkey 3) (parse-integer (substring line 25))))))
  (if (= 3 (mod c 7))
    (setf (aref monkey 4) (parse-integer (substring line 21))))
  (if (= 4 (mod c 7))
    (setf (aref monkey 5) (parse-integer (substring line 29))))
  (if (= 5 (mod c 7))
    (setf (aref monkey 6) (parse-integer (substring line 30))))
  (if (= 6 (mod c 7))
    (update_monkey)))

(let ((c 0))
  (with-open-file (stream "input2.txt")
    (loop for line = (read-line stream nil)
      while line do
        (parse line c)
        (incf c))))
(update_monkey)

(print monkeys)