(ns twobee.core
 (:gen-class))

(def keyswitch-height 14.4) ;; Was 14.1, then 14.25
(def keyswitch-width 14.4)

(def sa-profile-key-height 12.7)

	(def plate-thickness 4)
	(def mount-width (+ keyswitch-width 3))
(def mount-height (+ keyswitch-height 3))

	(def old-single-plate
	 (let [top-wall (->> (cube (+ keyswitch-width 3) 1.5 plate-thickness)
					 (translate [0
					  (+ (/ 1.5 2) (/ keyswitch-height 2))
					  (/ plate-thickness 2)]))
	  left-wall (->> (cube 1.5 (+ keyswitch-height 3) plate-thickness)
		  (translate [(+ (/ 1.5 2) (/ keyswitch-width 2))
		   0
		   (/ plate-thickness 2)]))
	  side-nub (->> (binding [*fn* 30] (cylinder 1 2.75))
		  (rotate (/ π 2) [1 0 0])
		  (translate [(+ (/ keyswitch-width 2)) 0 1])
		  (hull (->> (cube 1.5 2.75 plate-thickness)
				 (translate [(+ (/ 1.5 2) (/ keyswitch-width 2))
				  0
				  (/ plate-thickness 2)]))))
	  plate-half (union top-wall left-wall (with-fn 100 side-nub))]
	  (union plate-half
	   (->> plate-half
		(mirror [1 0 0])
		(mirror [0 1 0])))))
