DECLARE SUB OnDummyEvent (text$)

SUB OnDummyEvent (text$)
	PRINT "data: ", text$
END SUB

EVENT "/poke", OnDummyEvent

i=0

DO

	PRINT i
	i = i + 1
	WAIT 60

LOOP WHILE 1=1
