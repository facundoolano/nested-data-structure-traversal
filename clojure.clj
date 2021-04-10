(def sections [{:title                 "Getting started"
                :reset-lesson-position false
                :lessons               [{"name" "Welcome"}
                                        {"name" "Installation"}]}

               {:title                 "Basic operator"
                :reset-lesson-position false
                :lessons               [{"name" "Addition / Subtraction"}
                                        {"name" "Multiplication / Division"}]}

               {:title                 "Advanced topics"
                :reset-lesson-position true
                :lessons               [{"name" "Mutability"}
                                        {"name" "Immutability"}]}])

(defn traverse-sections
  [sections]
  (loop [[section & rest] sections
         position         1
         lesson-position  1
         result           []]
    (if section
      (let [lessons               (:lessons section)
            reset-lesson-position (:reset-lesson-position section)
            lessons               (traverse-lessons lessons lesson-position reset-lesson-position)
            last-lesson-position  (:position (last lessons))
            section               (assoc section :position position :lessons lessons)]
        (recur rest
               (inc position)
               (inc last-lesson-position)
               (conj result section)))
      result)))

(defn traverse-lessons
  [lessons position reset]
  (let [start (if reset 1 position)]
    (map-indexed (fn [index lesson]
                   (assoc lesson :position (+ index start)))
                 lessons)))

(print (traverse-sections sections))
