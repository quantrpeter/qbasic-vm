DECLARE SUB OnDummyEvent (text$)

SUB OnDummyEvent (text$)
	LOCATE 10
	PRINT "data: ", text$
END SUB

ON EVENT("/poke") GOSUB OnDummyEvent

i=0

DO

	LOCATE 1
	INPUT "Say "; Text$
	LOCATE 2
	PRINT Text$
	i = i + 1
	WAIT

LOOP WHILE 1=1