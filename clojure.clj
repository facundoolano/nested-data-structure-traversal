; java -cp clojure.jar clojure.main clojure.clj

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
  (first
   (reduce

    (fn [[result position lesson-position] section]
      (let [lessons               (:lessons section)
            reset-lesson-position (:reset-lesson-position section)
            lessons               (traverse-lessons lessons lesson-position reset-lesson-position)
            last-lesson-position  (:position (last lessons))
            section               (assoc section :position position :lessons lessons)]

        [(conj result section) (inc position) (inc last-lesson-position)]))

    [[] 1 1]
    sections)))


(defn traverse-lessons
  [lessons position reset]
  (let [start (if reset 1 position)]
    (map-indexed (fn [index lesson]
                   (assoc lesson :position (+ index start)))
                 lessons)))

(print (traverse-sections sections))
