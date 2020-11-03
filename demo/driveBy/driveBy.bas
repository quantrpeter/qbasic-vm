REM DriveBy v0.1
REM A RunOut clone in QBasic for Meritum Basic
REM Doesn't work great at the moment
REM ---

COLOR 1, 0, 0
CLS

DECLARE SUB DrawRoad (t)

DIM SHARED imgRoad AS INTEGER
DIM SHARED imgCar AS INTEGER
DIM SHARED imgSky AS INTEGER
imgRoad = LOADIMAGE("road.png")
imgCar = LOADIMAGE("car.png")
imgSky = LOADIMAGE("sky.png")

DIM SHARED turn AS INTEGER
DIM SHARED level AS INTEGER

turn = 0
level = 0

SPSET 1, imgCar
SPOFS 1, 45, 240

SUB DrawRoad (time)
	PUTIMAGE imgSky, -160 - (turn / 10), 20 - level

	Horizon = 180 - level
	imgWidth = 400
	imgHeight = 200
	roadMaxValue = (300 - Horizon + level - 1)
	j = 0
	FOR i = 0 TO roadMaxValue
		DIM Perspective AS SINGLE
		REM INT(240 - ((i / roadMaxValue) * 280))
		Perspective = INT(100 - 20 * SQR(i))
		PUTIMAGE imgRoad, 0, (Horizon + i - level), 160, 1, (120 - (Perspective / 2)) + (turn - (turn * (i / roadMaxValue))), ABS(j - time) MOD 200, (160 + Perspective), 1
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
	PRINT t, "      "
	PRINT "L=";
	PRINT level, "      "
	PRINT "TU=";
	PRINT turn, "      "
	PRINT "                    "
	t = t + 4

	REM ArrowLeft: 75,
    REM ArrowUp: 72,
    REM ArrowRight: 77,
	REM ArrowDown: 80,

	KeyPressed$ = INKEY$
	IF KeyPressed$ = (CHR$(0) + CHR$(75)) THEN
		turn = turn - 1
	ELSE IF KeyPressed$ = (CHR$(0) + CHR$(77)) THEN
		turn = turn + 1
	ELSE IF KeyPressed$ = (CHR$(0) + CHR$(72)) THEN
		level = level + 1
	ELSE IF KeyPressed$ = (CHR$(0) + CHR$(80)) THEN
		level = level - 1
	END IF

	YIELD
LOOP WHILE 1 = 1
