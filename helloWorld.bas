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
PRINT "Enter your name:"
INPUT Name$
PRINT "HELLO " + Name$;
