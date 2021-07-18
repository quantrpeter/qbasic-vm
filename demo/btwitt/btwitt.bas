ResCode% = -1
DIM Data$

DIM PageObjectsJ(0 TO 0) AS JSON
Page% = 0
RequestPage% = 1
Selected% = 0

DECLARE SUB FullLine (text$)

CONST ArrowLeft = (CHR$(0) + CHR$(75))
CONST ArrowRight = (CHR$(0) + CHR$(77))
CONST ArrowUp = (CHR$(0) + CHR$(72))
CONST ArrowDown = (CHR$(0) + CHR$(80))
CONST KeyA = (CHR$(97))

SUB FullLine (text$)
    length = LEN(text$)
	out$ = text$
	IF length / 20 > 2 THEN
		out$ = LEFT$(text$, 37) + "..."
	END IF
	PRINT out$;
	remain = 20 - (LEN(out$) MOD 20)
	FOR i = 1 TO remain
	 	PRINT " ";
	NEXT i
END SUB

DO
	CLS
	COLOR 1, 0
	PRINT " ART INSTITUTE OF   ";
	PRINT " CHICAGO            ";
	PRINT "                    "
	COLOR 0, 15


	IF RequestPage% <> Page% THEN
		LOCATE 5
		PRINT "Loading..."
		Page% = RequestPage%
		Selected% = 0
		FETCH "https://api.artic.edu/api/v1/artworks?page=" + STR$(Page%) + "&limit=10", ResCode%, Data$
		IF ResCode% = 200 THEN
			JSONREAD JSON(Data$), "$.data[*]", PageObjectsJ
		ELSE
			LOCATE 5
			PRINT "Failed to load: " + STR$(ResCode%)
		END IF
	END IF


	IF ResCode% = 200 THEN
		LOCATE 5
		FOR i = 1 TO LEN(PageObjectsJ)
			Title$ = JSONREAD$(PageObjectsJ(i), "$.title", "")
			Artist$ = JSONREAD$(PageObjectsJ(i), "$.artist_title", "Unknown")
			IF i = Selected% THEN
				COLOR 1, 0
			ELSE
				COLOR 0, 15
			END IF
			FullLine Title$
			COLOR 11
			FullLine Artist$
			COLOR 0, 15
		NEXT i
	END IF

	SLEEP
	Key$ = INKEY$
	
	IF Key$ = ArrowLeft THEN
		RequestPage% = MAX(1, Page% - 1)
	ELSE IF Key$ = ArrowRight THEN
		RequestPage% = Page% + 1
	ELSE IF Key$ = ArrowUp THEN
		Selected% = MAX(1, Selected% - 1)
	ELSE IF Key$ = ArrowDown THEN
		Selected% = MIN(LEN(PageObjectsJ), Selected% + 1)
	END IF
LOOP WHILE 1 = 1