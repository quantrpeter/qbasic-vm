DIM ResCode%
DIM Data$

Page% = 1

DO
	CLS
	COLOR 1, 0
	PRINT " ART INSTITUTE OF   ";
	PRINT " CHICAGO            ";
	PRINT "                    "
	COLOR 0, 15

	PRINT "Loading..."

	FETCH "https://api.artic.edu/api/v1/artworks?page=" + STR$(Page%) + "&limit=10", ResCode%, Data$
	LOCATE 5
	IF ResCode% = 200 THEN
		DIM ObjectsJ(1 TO 10) AS JSON
		JSONREAD JSONPARSE(Data$), "$.data[*]", ObjectsJ
		FOR i = 1 TO LEN(ObjectsJ)
			Title$ = JSONREAD$(ObjectsJ(i), "$.title", "")
			Artist$ = JSONREAD$(ObjectsJ(i), "$.artist_title", "Unknown")
			COLOR 0
			PRINT Title$
			COLOR 11
			PRINT Artist$
		NEXT i
	ELSE
		PRINT "Failed to load: " + STR$(ResCode%)
	END IF

	INC Page%
	
	SLEEP
LOOP WHILE 1 = 1