REM DriveBy v0.1
REM A RunOut clone in QBasic for Meritum Basic
REM Doesn't work great at the moment
REM ---

COLOR 1, 0, 0
CLS

DECLARE SUB DrawRoad (t)

DIM SHARED imgRoad AS INTEGER
DIM SHARED imgCar AS INTEGER
imgRoad = LOADIMAGE("road.png")
imgCar = LOADIMAGE("car.png")

SPSET 1, imgCar
SPOFS 1, 45, 240

SUB DrawRoad (time)
	Horizon = 180
	imgWidth = 400
	imgHeight = 200
	roadMaxValue = (300 - Horizon - 1)
	j = 0
	FOR i = 0 TO roadMaxValue
		DIM Perspective AS SINGLE
		Perspective = INT(240 - ((i / roadMaxValue) * 280))
		PUTIMAGE imgRoad, 0, (Horizon + i), 160, 1, (120 - (Perspective / 2)), ABS(j - time) MOD 200, (160 + Perspective), 1
		delta = INT(((1 - (i / roadMaxValue)) ^ 2) * 10)
		IF delta < 1 THEN
			delta = 1
		END IF
		j = j + delta
	NEXT i
END SUB

t = 0
DO
	DrawRoad(t)
	LOCATE 1, 1
	PRINT "T=";
	PRINT t, "    "
	PRINT "                  "
	t = t + 4
	YIELD
LOOP WHILE 1 = 1
