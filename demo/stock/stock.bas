ResCode% = -1
DIM Data$
DIM ResponseJ AS JSON

DIM SHARED Stocks(1 TO 3) AS STRING
Stocks(1) = "AAPL"
Stocks(2) = "MSFT"
Stocks(3) = "TSLA"

DIM SHARED Price(1 TO 3) AS DOUBLE
Price(1) = -1
Price(2) = -1
Price(3) = -1

DIM SHARED PrevPrice(1 TO 3) AS DOUBLE
PrevPrice(1) = -1
PrevPrice(2) = -1
PrevPrice(3) = -1

DIM SHARED imgLabels, imgNumbers
imgLabels = IMGLOAD("alien.png")
imgNumbers = IMGLOAD("money.png")

API_KEY$ = "OeAFFmMliFG5orCUuwAKQ8l4WWFQ67YX"
EODHD_API_URL$ = "wss://ws.eodhistoricaldata.com/ws/us?api_token=" + API_KEY$

DECLARE SUB FullLine (text$, lines%)
DECLARE SUB EmptyKeyBuf ()
DECLARE SUB ReadRecvMessages (Stocks$())
DECLARE FUNCTION Concat$ (Arr$())
DECLARE FUNCTION IndexOf% (Arr$(), Needle$)
DECLARE SUB PaintText (text$, font, x, y, w, h, letterSpacing)

CONST ArrowLeft = (CHR$(0) + CHR$(75))
CONST ArrowRight = (CHR$(0) + CHR$(77))
CONST ArrowUp = (CHR$(0) + CHR$(72))
CONST ArrowDown = (CHR$(0) + CHR$(80))
CONST KeyA = (CHR$(97))
CONST KeyEnter = (CHR$(0) + CHR$(13))
CONST KeyEscape = (CHR$(0) + CHR$(27))

CONST ScreenWidth = 20

SUB PaintText (text$, font, x, y, w, h, letterSpacing)
	Length = LEN(text$)
	Location = x
	FOR i = 1 TO Length
		SrcX = 0
		Advance = w
		Char = ASC(text$, i)
		IF (Char >= 48) AND (Char <= 57) THEN ' 0 - 9
			SrcX = (Char - 49)
			IF (SrcX < 0) THEN ' 0
				SrcX = 9
			END IF
		END IF 
		IF (Char >= 65) AND (Char <= 90) THEN ' A-Z
			SrcX = 10 + Char - 65
		END IF
		IF Char = 36 THEN ' Dollar sign
			SrcX = 40
		END IF
		IF Char = 46 THEN ' Period
			SrcX = 46
			Advance = w - 5
			Location = Location - 5
		END IF
		IMGPUT(font, Location, y, w, h, SrcX * w, 0, w, h)
		Location = Location + Advance + letterSpacing
	NEXT i
END SUB

SUB EmptyKeyBuf ()
	WHILE INKEY$ <> ""
	WEND
END SUB

SUB FullLine (text$, lines%)
    length = LEN(text$)
	out$ = text$
	IF length / ScreenWidth > lines% THEN
		out$ = LEFT$(text$, lines% * ScreenWidth - 3) + "..."
	END IF
	PRINT out$;
	remain = ScreenWidth - (LEN(out$) MOD ScreenWidth)
	IF remain < ScreenWidth THEN
		PRINT SPACE$(remain);
	END IF
END SUB

SUB ReadRecvMessages (Stocks$())
	Data$ = ""
	ResCode% = -1000
	DO
		' Receive incoming messages
		WSREAD DataMsg$, ResCode%
		IF ResCode% = 0 THEN
			DIM DataJ AS JSON
			DataJ = JSON(DataMsg$)
			Ticker$ = JSONREAD$(DataJ, "$.s", "")
			Price# = JSONREAD#(DataJ, "$.p")
			IF Ticker$ <> "" THEN
				Index = IndexOf%(Stocks, Ticker$)
				PrevPrice(Index) = Price(Index)
				Price(Index) = Price#
			END IF
		END IF
	LOOP WHILE ResCode% = 0
END SUB

FUNCTION Concat$ (Arr$())
	Out$ = ""
	Length = LEN(Arr$)
	FOR i = 1 TO Length
		Out$ = Out$ + Arr$(i)
		IF i < Length THEN
			Out$ = Out$ + ", "
		END IF
	NEXT i
	Concat$ = Out$
END FUNCTION

FUNCTION IndexOf% (Arr$(), Needle$)
	Index% = 0
	Length = LEN(Arr$)
	FOR i = 1 TO Length
		IF Arr$(i) = Needle$ THEN
			Index% = i
			i = Length + 1
		END IF
	NEXT i
	IndexOf% = Index%
END FUNCTION

COLOR 15, 0
CLS

' Open WebSocket connection to the EOD Historical Data WebSocket API
' See: https://eodhistoricaldata.com/financial-apis/new-real-time-data-api-websockets/
WSOPEN EODHD_API_URL$, ResCode%
IF ResCode% <> 0 THEN
	PRINT "Could not connect to EOD Historical Data WebSocket service."
	END
END IF

DIM SubscriptionJ AS JSON
SubscriptionJ = JSON()
' Build a subscription object
JSONWRITE(SubscriptionJ, "$.action", "subscribe")
JSONWRITE(SubscriptionJ, "$.symbols", Concat$(Stocks))
WSWRITE JSONSTR$(SubscriptionJ)

DO

	ReadRecvMessages(Stocks)
	GOSUB ViewList
	WAIT

LOOP WHILE 1 = 1

Header:
	CLS
	' COLOR 1, 8
	' PRINT " EOD HISTORICAL     ";
	' PRINT " DATA               ";
	' PRINT "                    "
	' COLOR 15, 0
	RETURN


ViewList:
	GOSUB Header
	LOCATE 5, 1

	FOR i = 1 TO LEN(Stocks)
		Price$ = "$" + LEFT$(STR$(Price(i)), 6)
		PaintText(Stocks(i), imgLabels, 30, 0 + ((i - 1) * 100), 25, 24, 0)
		PaintText(Price$, imgNumbers, -5, 30 + ((i - 1) * 100), 50, 48, -28)
	NEXT i

	RETURN