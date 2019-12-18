DECLARE SUB PrintRainbow (text$)

SUB PrintRainbow (text$)
	Length = LEN(text$)
	FOR i = 1 TO Length
		COLOR i MOD 16
        PRINT MID$(text$, i, 1);
	NEXT i
	COLOR 0, 15
END SUB

PrintRainbow "HELLO WORLD!"
PRINT ""
PRINT "Press ANY key"
SLEEP
PLAY "t200 o6 l8 e g > e c d g"
PRINT "Enter your name:"
INPUT Name$
PRINT "HELLO " + Name$
