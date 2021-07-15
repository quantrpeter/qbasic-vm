REM DriveBy v0.1
REM A RunOut clone in QBasic for Meritum Basic
REM Doesn't work great at the moment
REM ---

CONST TRUE = -1
CONST FALSE = NOT TRUE

CONST ArrowLeft = (CHR$(0) + CHR$(75))
CONST ArrowRight = (CHR$(0) + CHR$(77))
CONST ArrowUp = (CHR$(0) + CHR$(72))
CONST ArrowDown = (CHR$(0) + CHR$(80))
CONST KeyA = (CHR$(97))
CONST KeyS = (CHR$(115))
CONST KeyE = (CHR$(101))
CONST KeyD = (CHR$(100))
CONST KeyM = (CHR$(109))

COLOR 1, 0, 0
CLS

DECLARE SUB DrawRoad (t)

DIM SHARED imgRoad, imgCar, imgSky
imgRoad = LOADIMAGE("road.png")
imgCar = LOADIMAGE("car.png")
imgSky = LOADIMAGE("sky.png")

DIM SHARED turn, level, slide, speed
lastPeriod# = TIMER
lastF = 0

turn = 0
level = 0
slide = 22
speed = 4

SPSET 1, imgCar
SPOFS 1, 45, 240

SUB DrawRoad (time)
	PUTIMAGE imgSky, -160 - (turn / 10) - (slide / 20), 20 - level

	Horizon = 180 - level
	imgWidth = 400
	imgHeight = 200
	roadMaxValue = (300 - Horizon + level - 1)
	j = 0
	FOR i = 0 TO roadMaxValue
		DIM Perspective AS SINGLE
		REM INT(240 - ((i / roadMaxValue) * 280))
		Perspective = INT(100 - 20 * SQR(i))
		PUTIMAGE imgRoad, 0, (Horizon + i - level), 160, 1, (120 - (Perspective / 2)) + (turn - (turn * (i / roadMaxValue))) + slide, ABS(j - time) MOD 200, (160 + Perspective), 1
		delta = INT(((1 - (i / roadMaxValue)) ^ 2) * 10)
		IF delta < 1 THEN
			delta = 1
		END IF
		j = j + delta
	NEXT i
END SUB

CONST Song0$ = "t132v127o5a+8.r4r16a+16r16a+16a+16g+16a+8r16a+8.r4r16a+16r16a+16a+16g+16a+8r16a+8.r8.>c16c+8.<a+8r8g+4f+8r8d+8d+8f8f+8d+8,v100o3d+8r4d+8r4d+8r8<b8r4b8r4b8r8f+8r4f+8r4f+8r8a+8r4a+8r4a+8r8,v60o6d+32r32d+32r32d+8d+32r32d+32r32d+8d+32r32d+32r32d+8d+32r32d+32r32d+8f+32r32f+32r32f+8f+32r32f+32r32f+8f+32r32f+32r32f+8f+32r32f+32r32f+8d+32r32d+32r32d+8d+32r32d+32r32d+8d+32r32d+32r32d+8d+32r32d+32r32d+8a+32r32a+32r32a+8a+32r32a+32r32a+8a+32r32a+32r32a+8a+32r32a+32r32a+8"
CONST Song1$ = "t152o5b2a1a8f+4.b4f+8f+4e4f+1f+2f+8d4.c+4.<b1b2.>b2a1a8f+4.>d4c+4<b8a4f+1f+2<b8>d8d8<b8>d2d8d8d8<b8>d4<b4>d1d1,o3b8b8>f+8<b8>f+8f+8<b8>f+8<b8b8>f+8<b8>>c+8c+8c+8<<d8g8g8>d8<g8g8g8>a8<g8b8b8>f+8<b8b8b8>f+8<b8b8b8>f+8<b8b8b8>f+8<b8d8d8>f+8<d8>f+8f+8<d8>f+8f+8<d8>f+8<d8>f+8f+8f+8<d8b8b8>f+8<b8>f+8f+8<b8>f+8<b8b8>f+8<b8>>c+8c+8c+8<<d8g8g8>d8<g8g8g8>a8<g8b8b8>f+8<b8b8b8>f+8<b8b8b8>f+8<b8b8b8>f+8<b8d8d8d8d8d8d8d8d8d8d8d8d8d8d8d8d8"
CONST Song2$ = "l8g+c-g+c-g+c-g+c-f+c-f+c-f+c-f+c-e<g+>e<g+>e<g+>e<g+>e<a>e<g+>e<a>e<a>g+<b>g+<b>g+<b>g+<b>f+<b>f+<b>f+<b>f+<b>e<g+>e<g+>e<g+>e<g+>e<a>e<g+>e<a>e<al1.rrrrrrrrrrr1r2l8>c+c+2c+c+e2ee2eeeeb4al4.g+f+4c+c+2c+8c+e4f+8e8f+l8g+e2e>d+r4e2e,o4l1.rrrrrr2r2r4l8>g+ef+f+4g+4.r2r4eeeeb4bg+4f+4.r2rc-g+ef+f+4g+4g+32f+.ee32f+4.g+4.e2.r1r4g+ef+f+4g+4.r2r4eeeeb4bg+4f+4.r2rc-g+ef+f+4g+4g+32f+.ee32f+4g+l4.f+g+8f+g+8g+16f+16e2f+er4f+g+r2r4l8eeeeb4al4.g+g+4f+er4f+g+4f+8e8f+g+8e,o3e2l8ef+g+b2.>c+d+c+2.d+e<a2.>d+e<e2.f+g+b2.>c+d+<g+2.g+g+a2.>d+e4l2bbbb>c+c+c+c+<bg+bbbb>c+c+<bbbb>c+c+c+c+<bg+bbbb>c+c+4c+4"

REM DIM SHARED song
REM song = 0

REM SUB NextSong ()
REM 	song = (song + 1) MOD 2
REM 	IF song = 0 THEN
REM 		BGMPLAY Song0$
REM 	ELSE IF song = 1 THEN
REM 		BGMPLAY Song1$
REM 	END IF
REM END SUB

REM BGMPLAY Song2$

t = 0
f = 0
DO
	DrawRoad(t)

	IF f MOD 60 = 0 THEN
		lastPeriod# = TIMER
		lastF = f
	END IF
	
	LOCATE 1, 1
	
	PRINT "FPS=";
	IF f - lastF = 0 THEN
		PRINT "0     "
	ELSE
		PRINT INT((f - lastF) / (TIMER - lastPeriod#)), "      "
	END IF
	PRINT "L=";
	PRINT level, "      "
	PRINT "TU=";
	PRINT turn, "      "
	PRINT "SL=";
	PRINT slide, "      "
	PRINT "SP=";
	PRINT speed,  "      "
	PRINT "                    "

	KeyPressed$ = INKEY$
	IF KeyPressed$ = ArrowLeft THEN
		turn = turn - 1
	ELSE IF KeyPressed$ = ArrowRight THEN
		turn = turn + 1
	ELSE IF KeyPressed$ = ArrowUp THEN
		level = level + 1
	ELSE IF KeyPressed$ = ArrowDown THEN
		level = level - 1
	ELSE IF KeyPressed$ = KeyA THEN
		slide = slide - 1
	ELSE IF KeyPressed$ = KeyS THEN
		slide = slide + 1
	ELSE IF KeyPressed$ = KeyE THEN
		speed = speed + 1
	ELSE IF KeyPressed$ = KeyD THEN
		speed = speed - 1
		IF speed < 0 THEN
			speed = 0
		END IF
	ELSE IF KeyPressed$ = KeyM THEN
		REM NextSong
	END IF

	f = f + 1
	t = t + speed

	YIELD
LOOP WHILE 1 = 1
