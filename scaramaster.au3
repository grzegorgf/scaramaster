#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ComboConstants.au3>
#include <StructureConstants.au3>
#include <WinAPIConstants.au3>
#include <StatusBarConstants.au3>
#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <File.au3>
#include <String.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <GUIEdit.au3>
#include <ScrollBarConstants.au3>
#include <Date.au3>
#include <Math.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <array.au3>
#include <MsgBoxConstants.au3>
#include <ColorConstants.au3>
#include <SliderConstants.au3>
#include <GDIPlus.au3>
#include <GuiStatusBar.au3>
#include <WinAPI.au3>
#include <AutoItConstants.au3>
#include <Misc.au3>
#include <GuiComboBox.au3>
#include <Timers.au3>
#include <GDIPlus.au3>
#include <ScrollBarsConstants.au3>
#include <FileConstants.au3>
#include <WinAPIFiles.au3>
#include <FrameConstants.au3>
#include <GuiMenu.au3>
#include <MenuConstants.au3>
#include <Crypt.au3>
#include <GDIPlus.au3>
#include <StringConstants.au3>
#include "scaramaster_comm.au3"


Run(@ScriptDir & '\loadmgr.dll Initializing SCARA Master')

Opt("GUIOnEventMode", 1)

Global $stamplog = @YEAR & @MON & @MDAY & " " & @HOUR & @MIN & @SEC
While ProcessExists("iomgr.dll")
	ProcessClose("iomgr.dll")
	Sleep(100)
WEnd
Global $posX = 0
Global $posY = 0
Global $posE = 0
Global $posZ = 0
Global $posG = 0

Global $statuslogpth = @ScriptDir & "\log\" & $stamplog&"\"& $stamplog & " status.log"
Global $statuslogh, $reconnectAfterTimeout = 0
$statuslogh = Run(@ScriptDir & "\iomgr.dll "&$statuslogpth, @ScriptDir, @SW_HIDE, $STDIN_CHILD + $STDOUT_CHILD)
StdinWrite($statuslogh, @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & ": Initializing interface")


;--------------------------------------------------------------------------------
$mainGUI = GUICreate("SCARA Master", 511, 434, 233, 171)
$ButtonX1 = GUICtrlCreateButton("X-10", 24, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonX2 = GUICtrlCreateButton("X-1", 88, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonX3 = GUICtrlCreateButton("X-0,1", 152, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonX4 = GUICtrlCreateButton("X+0,1", 224, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonX5 = GUICtrlCreateButton("X+1", 288, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonX6 = GUICtrlCreateButton("X+10", 352, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY1 = GUICtrlCreateButton("Y-10", 24, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY2 = GUICtrlCreateButton("Y-1", 88, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY3 = GUICtrlCreateButton("Y-0,1", 152, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY4 = GUICtrlCreateButton("Y+0,1", 224, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY5 = GUICtrlCreateButton("Y+1", 288, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonY6 = GUICtrlCreateButton("Y+10", 352, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE1 = GUICtrlCreateButton("E-10", 24, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE2 = GUICtrlCreateButton("E-1", 88, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE3 = GUICtrlCreateButton("E-0,1", 152, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE4 = GUICtrlCreateButton("E+0,1", 224, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE5 = GUICtrlCreateButton("E+1", 288, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonE6 = GUICtrlCreateButton("E+10", 352, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ6 = GUICtrlCreateButton("Z+10", 432, 24, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ5 = GUICtrlCreateButton("Z+1", 432, 88, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ4 = GUICtrlCreateButton("Z+0,1", 432, 152, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ3 = GUICtrlCreateButton("Z-0,1", 432, 224, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ2 = GUICtrlCreateButton("Z-1", 432, 288, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonZ1 = GUICtrlCreateButton("Z-10", 432, 352, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG1 = GUICtrlCreateButton("G-10", 24, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG2 = GUICtrlCreateButton("G-1", 88, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG3 = GUICtrlCreateButton("G-0,1", 152, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG4 = GUICtrlCreateButton("G+0,1", 224, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG5 = GUICtrlCreateButton("G+1", 288, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")
$ButtonG6 = GUICtrlCreateButton("G+10", 352, 216, 49, 49)
GUICtrlSetOnEvent(-1, "_ButtonMove")

$Label1 = GUICtrlCreateLabel("X:", 24, 312, 14, 17)
$InputX = GUICtrlCreateInput("-", 40, 312, 49, 21)

$Label2 = GUICtrlCreateLabel("Y:", 96, 312, 14, 17)
$InputY = GUICtrlCreateInput("-", 112, 312, 49, 21)

$Label3 = GUICtrlCreateLabel("E:", 168, 312, 14, 17)
$InputE = GUICtrlCreateInput("-", 184, 312, 49, 21)

$Label4 = GUICtrlCreateLabel("Z:", 240, 312, 14, 17)
$InputZ = GUICtrlCreateInput("-", 256, 312, 49, 21)

$Label5 = GUICtrlCreateLabel("G:", 336, 312, 14, 17)
$InputG = GUICtrlCreateInput("-", 352, 312, 49, 21)


$ButtonGoTo = GUICtrlCreateButton("Go To", 336, 352, 65, 49)
GUICtrlSetOnEvent(-1, "_ButtonGoTo")
$ButtonHome = GUICtrlCreateButton("Home", 240, 352, 65, 49)
GUICtrlSetOnEvent(-1, "_ButtonHome")
$ButtonDraft = GUICtrlCreateButton("Draft move", 136, 352, 65, 49)
GUICtrlSetOnEvent(-1, "_ButtonDraftMove")
$ButtonRun = GUICtrlCreateButton("Run move", 40, 352, 65, 49)
GUICtrlSetOnEvent(-1, "_ButtonRunMove")
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $mainGUI)

;--------------------------------------------------------------------------------
$draftGUI = GUICreate("Draft move", 474, 361, 302, 218)
$EditMove = GUICtrlCreateEdit("HOME", 16, 16, 441, 265)
GUICtrlSetData(-1, "")
$ButtonDraftSave = GUICtrlCreateButton("Save", 192, 304, 89, 41)
GUICtrlSetOnEvent(-1, "_ButtonDraftSave")
$ButtonDraftClose = GUICtrlCreateButton("Close", 368, 304, 89, 41)
GUICtrlSetOnEvent(-1, "_ButtonDraftClose")
$ButtonDraftSnap = GUICtrlCreateButton("Snap", 16, 304, 89, 41)
GUICtrlSetOnEvent(-1, "_ButtonDraftSnap")
GUISetOnEvent($GUI_EVENT_CLOSE, "_ButtonDraftClose", $draftGUI)


_init()

Global $mscheckinterval = 1000, $lastcheckedms = 0, $sleepintervalms = 100

GUISetState(@SW_SHOW, $mainGUI)
;Sleep(5000)
ProcessClose("loadmgr.dll")

While 1
	Sleep($sleepintervalms)
	inputChecker()
WEnd


Func inputChecker()
	Local $filecontent, $donehdl, $inputhdl
	$lastcheckedms += $sleepintervalms
	If $lastcheckedms > $mscheckinterval Then
		$lastcheckedms = 0
		$filecontent = FileRead(@ScriptDir & "\input.tmp")
		If $filecontent <> "" Then
			_MoveParser($filecontent)
			$donehdl = FileOpen(@ScriptDir & "\output.tmp", 2)
			FileWrite($donehdl, "DONE")
			$inputhdl = FileOpen(@ScriptDir & "\input.tmp", 2)
			FileWrite($inputhdl, "")
		EndIf
	EndIf
EndFunc

Func instrumentMove($movex, $movey, $movee, $movez, $moveg, $rel = 0)
	If $rel = 0 Then
		Local $newX = $moveX
		Local $newY = $moveY
		Local $newE = $moveE
		Local $newZ = $moveZ
		Local $newG = $moveG
	Else
		Local $newX = $posX + $moveX
		Local $newY = $posY + $moveY
		Local $newE = $posE + $moveE
		Local $newZ = $posZ + $moveZ
		Local $newG = $posG + $moveG
	EndIf
	If $newG <> $posG Then
		 statusUpdate("Move G to "&$newG)
		 _CommSendString("M280 P0 S"&$newG & @LF, 1)
		 GUICtrlSetData($InputG, $newG)
	EndIf
	If $newZ <> $posZ Then
		 statusUpdate("Move Z to "&$newZ)
		 _CommSendString("G0 Z"& $newZ & " F3000" & @LF, 1)
		 GUICtrlSetData($InputZ, $newZ)
	EndIf
	If $newX <> $posX And $newY <> $posY Then
		 statusUpdate("Move X to "&$newX &" and Y to "&$newY)
		 _CommSendString("G0 X" & $newX & " Y" & $newY & " F30000" & @LF, 1)
		 GUICtrlSetData($InputX, $newX)
		 GUICtrlSetData($InputY, $newY)
	Else
		 If $newX <> $posX Then
			 statusUpdate("Move X to "&$newX)
			 _CommSendString("G0 X"& $newX & " F30000" & @LF, 1)
			 GUICtrlSetData($InputX, $newX)
		 EndIf
		 If $newY <> $posY Then
			 statusUpdate("Move Y to "&$newY)
			 _CommSendString("G0 Y"& $newY & " F30000" & @LF, 1)
			 GUICtrlSetData($InputY, $newY)
		 EndIf
	EndIf
	 If $newE <> $posE Then
		 statusUpdate("Move E to "&$newE)
		 _CommSendString("G0 E"& $newE & " F30000" & @LF, 1)
		 GUICtrlSetData($InputE, $newE)
	 EndIf
	; -------- confirmation M400 ---------------------------------------
	_CommGetLine('', 0, 50)
	_CommClearInputBuffer()
	_CommSendString("M400" & @LF, 1)
	_CommSendString("M400" & @LF, 1)
	Local $k = 0
	Local $instr = ''
	Local $flagResponse = 0, $movesearchstring = "RD"
	While $k < 20
		$instr = $instr & _CommGetLine(@CR, 0, 25)
		If $instr <> '' Then
			If StringInStr($instr, $movesearchstring) <> 0 Then
				statusUpdate("Movement confirmed")
				$flagResponse = 1
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	If $flagResponse = 0 Then ; retry
		_CommSendString("M400" & @LF, 1)
		$k = 0
		While $k < 200
			$instr = $instr & _CommGetLine(@CR, 0, 25)
			If $instr <> '' Then
				If StringInStr($instr, $movesearchstring) <> 0 Then
					statusUpdate("Movement confirmed")
					$flagResponse = 1
					ExitLoop
				EndIf
			EndIf
			$k += 1
		WEnd
		If $flagResponse = 0 Then
			$timeoutTriggerFlag = 1
			statusUpdate("Invalid response: " & $instr, 0)
			If $reconnectAfterTimeout <> 0 Then
				statusUpdate("Response timeout. Last response: " & $instr & " Requesting reconnection.")
			Else
				statusUpdate("Response timeout. Last response: " & $instr & " Considered executed.")
			EndIf
		EndIf
	EndIf
	$instr = ''

	 $posX = $newX
	 $posY = $newY
	 $posE = $newE
	 $posZ = $newZ
	 $posG = $newG


EndFunc



Func _ButtonGoTo()
	instrumentMove(GUICtrlRead($InputX), GUICtrlRead($InputY), GUICtrlRead($InputE), GUICtrlRead($InputZ), GUICtrlRead($InputG), 0)
EndFunc

Func _ButtonHome()
	Run(@ScriptDir & '\loadmgr.dll Homing')
	_Home()
	ProcessClose("loadmgr.dll")
EndFunc

Func _Home()

	Local $k, $flag, $instr = ""
	 ; ---------- Z ----------------------------------------------------
	$flag = 0
	statusUpdate("Home Z axis")
	_CommGetLine(@CR, 10000, 200)
	_CommSendString("G28 Z" & @LF)
	$instr = ''
	$k = 0
	$flag = 0
	While $k < 450
		$instr = _CommGetLine(@CR, 10, 100)
		If $instr <> '' Then
			If StringInStr($instr, "X:") <> 0 Then
				$flag = 1
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	$instr = ''
	If $flag <> 0 Then
		statusUpdate("Z axis homed")
	Else
		statusUpdate("Error: Z axis homing timeout")
	EndIf
	 ; ---------- X ----------------------------------------------------
	$flag = 0
	statusUpdate("Home X axis")
	_CommGetLine(@CR, 10000, 200)
	_CommSendString("G90" & @LF, 1)
	_CommSendString("G0 X400 F10000" & @LF, 1)
	_CommSendString("G28 X" & @LF)
	$instr = ''
	$k = 0
	$flag = 0
	While $k < 450
		$instr = _CommGetLine(@CR, 10, 100)
		If $instr <> '' Then
			If StringInStr($instr, "X:") <> 0 Then
				$flag = 1
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	$instr = ''
	If $flag <> 0 Then
		statusUpdate("X axis homed")
	Else
		statusUpdate("Error: X axis homing timeout")
	EndIf
	 ; ---------- E ----------------------------------------------------
	_CommClearInputBuffer()
	statusUpdate("Home E axis")
	_CommSendString("G91" & @LF, 1)
	_CommSendString("G0 Y300 F10000" & @LF, 1)
	; _CommSendString("G90" & @LF, 1)
	_CommSendString("G0 E500 F10000" & @LF, 1)
	_CommSendString("G91" & @LF, 1)
	_CommSendString("M120" & @LF, 1)
	sleep(100)
	_CommSendString("M120" & @LF, 1)
	sleep(100)
	_CommSendString("M120" & @LF, 1)
	_CommSendString("G0 E-2000 F10000" & @LF, 1)
	$k = 0
	$instr = ""
	While $k < 800
		$instr = $instr & _CommGetLine(@CR, 200, 250)
		sleep(250)
		If $instr <> '' Then
			If StringInStr($instr, " E:") <> 0 Then
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	;_CommSendString("M121" & @LF, 1)
	_CommSendString("G0 E40 F10000" & @LF, 1)
	_CommClearInputBuffer()

	_CommSendString("M120" & @LF, 1)
	sleep(100)
	_CommSendString("M120" & @LF, 1)
	sleep(100)
	_CommSendString("M120" & @LF, 1)
	_CommGetLine("?", 10000, 1000)
	_CommSendString("G0 E-41 F1000" & @LF, 1)
	$k = 0
	$instr = ""
	While $k < 40
		$instr = $instr & _CommGetLine(@CR, 200, 250)
		sleep(250)
		If $instr <> '' Then
			If StringInStr($instr, " E:") <> 0 Then
				$flag = 1
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	_CommSendString("G92 E0" & @LF)
	_CommSendString("M121" & @LF, 1)
	_CommSendString("G90" & @LF, 1)
	_CommGetLine(@CR, 10000, 250)
	_CommClearInputBuffer()
	If $flag <> 0 Then
		statusUpdate("E axis homed")
	Else
		statusUpdate("Error: E axis homing timeout")
	EndIf
	 ; ---------- Y ----------------------------------------------------
	$flag = 0
	statusUpdate("Home Y axis")
	_CommGetLine(@CR, 10000, 200)
	_CommSendString("G28 Y" & @LF)
	$instr = ''
	$k = 0
	$flag = 0
	While $k < 450
		$instr = _CommGetLine(@CR, 10, 100)
		If $instr <> '' Then
			If StringInStr($instr, "X:") <> 0 Then
				$flag = 1
				ExitLoop
			EndIf
		EndIf
		$k += 1
	WEnd
	$instr = ''
	If $flag <> 0 Then
		statusUpdate("Y axis homed")
	Else
		statusUpdate("Error: Y axis homing timeout")
	EndIf
	 ; ---------- G ----------------------------------------------------
	 statusUpdate("Home G axis")
	 _CommSendString("M280 P0 S0" & @LF, 1)
	 statusUpdate("G axis homed")

	 _CommSendString("M211 S0" & @LF, 1)
	 _CommSendString("M121" & @LF, 1)

	 $posX = 0
	 $posY = 0
	 $posE = 0
	 $posZ = 165
	 $posG = 0
	 GUICtrlSetData($InputX, $posX)
	 GUICtrlSetData($InputY, $posY)
	 GUICtrlSetData($InputE, $posE)
	 GUICtrlSetData($InputZ, $posZ)
	 GUICtrlSetData($InputG, $posG)


EndFunc

Func _ButtonDraftMove()
	GUICtrlSetData($EditMove, "HOME")
	GUISetState(@SW_SHOW, $draftGUI)
EndFunc

Func _ButtonDraftClose()
	GUISetState(@SW_HIDE, $draftGUI)
EndFunc

Func _ButtonDraftSave()
	Local $filepath, $movetxt, $hdlsave
	$filepath = FileSaveDialog("Save move", @ScriptDir & "\protocols", "Text file (*.txt)")
	If $filepath <> "" Then
		Run(@ScriptDir & '\loadmgr.dll Saving protocol')
		If @error <> 1 Then
			$movetxt = GUICtrlRead($EditMove)
			If FileExists($filepath) = 1 Then
				FileDelete($filepath)
			EndIf
			$hdlsave = FileOpen($filepath, 2)
			If $hdlsave <> -1 Then
				FileWrite($hdlsave, $movetxt)
				FileClose($hdlsave)
				statusUpdate("Protocol saved to " & $filepath)
			Else
				statusUpdate("Error saving protocol to " & $filepath)
			EndIf
		Else
			statusUpdate("Error saving protocol file")
		EndIf
		ProcessClose("loadmgr.dll")
	EndIf
EndFunc

Func _ButtonDraftSnap()
	_GUICtrlEdit_AppendText($EditMove, @CRLF & $posX & ";"& $posY & ";"& $posE & ";"& $posZ & ";"& $posG)
EndFunc

Func _ButtonRunMove()
	Local $sFile, $movetxt, $hdlsave
	$sFile = FileOpenDialog("Choose move file", @ScriptDir & "\protocols", "Text file (*.txt)")
	If $sFile <> "" Then
		If @error <> 1 Then
			$hdlsave = FileOpen($sFile, 0)
			$movetxt = FileRead($hdlsave)
			FileClose($hdlsave)
			_MoveParser($movetxt)
		Else
			statusUpdate("Error opening move file")
		EndIf
	EndIf
EndFunc

Func _MoveParser($moveString)
	Run(@ScriptDir & '\loadmgr.dll Executing move')
	Local $readarr = StringSplit($moveString, @CRLF, 3)
	Local $linesplit
	Local $k = 0
	While $k < UBound($readarr)
		If $readarr[$k] = "HOME" Then
			_Home()
		ElseIf StringLeft($readarr[$k],4) = "WAIT" Then
			statusUpdate("Wait for "&StringTrimLeft($readarr[$k], 5)& " ms")
			Sleep(StringTrimLeft($readarr[$k], 5))
		Else
			$linesplit = StringSplit($readarr[$k], ";", 3)
			If UBound($linesplit) = 5 Then
				instrumentMove($linesplit[0], $linesplit[1], $linesplit[2], $linesplit[3], $linesplit[4], 0)
			EndIf
		EndIf
		$k += 1
	WEnd
	sleep(200)
	webcamSnap()
	sleep(500)
	While ProcessExists("loadmgr.dll")
		ProcessClose("loadmgr.dll")
		Sleep(100)
	WEnd
EndFunc

Func _init()
	Local $sportSetError, $resOpen, $instr, $connectedflag = 0
	Local $conArr2[10]
	$conArr2 = _CommListPorts(2)
	_CommClosePort(True)
	statusUpdate("Establishing connection to instrument")
	If IsArray($conArr2) Then
		If $conArr2[0] < 1 Then
			statusUpdate("Unable to connect to instrument: Instrument ports not detected 0x1")
			;Exit
		Else
			_CommSwitch(1)
			statusUpdate("Probing serial ports")
			Local $h = 1
			While $h < ($conArr2[0] + 1)
				$resOpen = _CommSetPort(Number(StringReplace($conArr2[$h], "COM", "")), $sportSetError, "9600", "8", 0, "1", 0)
				If $resOpen = 0 Then
					statusUpdate("Unable to connect to client COM"&$h&": " & $sportSetError)
				Else
					_CommGetLine(@CR, 0, 100)
					_CommClearInputBuffer()
					_CommSendString("M400" & @LF, 1)
					_CommSendString("M400" & @LF, 1)
					Local $k = 0
					$instr = ""
					Sleep(50)
					$instr = _CommGetLine("", 200, 2000)
					If $instr <> '' Then
						If StringInStr($instr, "ok") <> 0 Then
							statusUpdate("Positional module ready at COM" & Number(StringReplace($conArr2[$k], "COM", "")))
							statusUpdate("Connection to positional module established")
							_CommGetLine("", 20000, 50)
							$connectedflag = 1
							ExitLoop
						Else
							statusUpdate("Invalid response from " & $conArr2[$k] & ": " & $instr & " Switching comms. Error: " & @error, 0)
							_CommClosePort()
						EndIf
					Else
						statusUpdate("No response from " & $conArr2[$h] & ": " & $instr & " Switching comms. Error: " & @error, 0)
						_CommClosePort()
					EndIf
				EndIf
				$h += 1
			WEnd
		EndIf
	Else
		statusUpdate("Unable to connect to instrument: Instrument ports not detected 0x0")
		;Exit
	EndIf
	If $connectedflag = 0 Then
		statusUpdate("Unable to connect to instrument")
		#Region --- CodeWizard generated code Start ---
		;MsgBox features: Title=Yes, Text=Yes, Buttons=Retry and Cancel, Icon=Critical
		If Not IsDeclared("iMsgBoxAnswer") Then Local $iMsgBoxAnswer
		$iMsgBoxAnswer = MsgBox(21,"Connection failed","Unable to connect to instrument, check log for details.")
		Select
			Case $iMsgBoxAnswer = 4 ;Retry
				_init()
			Case $iMsgBoxAnswer = 2 ;Cancel
				_Exit()
		EndSelect
		#EndRegion --- CodeWizard generated code End ---

		;Exit
	EndIf

EndFunc

Func _Exit()
	While ProcessExists("iomgr.dll")
		ProcessClose("iomgr.dll")
		Sleep(100)
	WEnd
	While ProcessExists("loadmgr.dll")
		ProcessClose("loadmgr.dll")
		Sleep(100)
	WEnd
	GUISetState(@SW_HIDE, $mainGUI)
	GUISetState(@SW_HIDE, $draftGUI)
	Exit
EndFunc

Func statusUpdate($text, $dummy=0)
	StdinWrite($statuslogh, @CRLF & @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC & ": "&$text)
EndFunc

Func _ButtonMove()
	Local $setrefhndl = @GUI_CtrlId
	Switch $setrefhndl
		Case $ButtonX1
			instrumentMove(-10, 0, 0, 0, 0, 1)
		Case $ButtonX2
			instrumentMove(-1, 0, 0, 0, 0, 1)
		Case $ButtonX3
			instrumentMove(-0.1, 0, 0, 0, 0, 1)
		Case $ButtonX4
			instrumentMove(0.1, 0, 0, 0, 0, 1)
		Case $ButtonX5
			instrumentMove(1, 0, 0, 0, 0, 1)
		Case $ButtonX6
			instrumentMove(10, 0, 0, 0, 0, 1)
		Case $ButtonY1
			instrumentMove(0, -10, 0, 0, 0, 1)
		Case $ButtonY2
			instrumentMove(0, -1, 0, 0, 0, 1)
		Case $ButtonY3
			instrumentMove(0, -0.1, 0, 0, 0, 1)
		Case $ButtonY4
			instrumentMove(0, 0.1, 0, 0, 0, 1)
		Case $ButtonY5
			instrumentMove(0, 1, 0, 0, 0, 1)
		Case $ButtonY6
			instrumentMove(0, 10, 0, 0, 0, 1)
		Case $ButtonE1
			instrumentMove(0, 0, -10, 0, 0, 1)
		Case $ButtonE2
			instrumentMove(0, 0, -1, 0, 0, 1)
		Case $ButtonE3
			instrumentMove(0, 0, -0.1, 0, 0, 1)
		Case $ButtonE4
			instrumentMove(0, 0, 0.1, 0, 0, 1)
		Case $ButtonE5
			instrumentMove(0, 0, 1, 0, 0, 1)
		Case $ButtonE6
			instrumentMove(0, 0, 10, 0, 0, 1)
		Case $ButtonZ1
			instrumentMove(0, 0, 0, -10, 0, 1)
		Case $ButtonZ2
			instrumentMove(0, 0, 0, -1, 0, 1)
		Case $ButtonZ3
			instrumentMove(0, 0, 0, -0.1, 0, 1)
		Case $ButtonZ4
			instrumentMove(0, 0, 0, 0.1, 0, 1)
		Case $ButtonZ5
			instrumentMove(0, 0, 0, 1, 0, 1)
		Case $ButtonZ6
			instrumentMove(0, 0, 0, 10, 0, 1)
		Case $ButtonG1
			instrumentMove(0, 0, 0, 0, -10, 1)
		Case $ButtonG2
			instrumentMove(0, 0, 0, 0, -1, 1)
		Case $ButtonG3
			instrumentMove(0, 0, 0, 0, -0.1, 1)
		Case $ButtonG4
			instrumentMove(0, 0, 0, 0, 0.1, 1)
		Case $ButtonG5
			instrumentMove(0, 0, 0, 0, 1, 1)
		Case $ButtonG6
			instrumentMove(0, 0, 0, 0, 10, 1)
	EndSwitch
EndFunc


Func webcamSnap()
   If WinExists("Yawcam - Yet Another Webcam Software") Then
			WinActivate("Yawcam - Yet Another Webcam Software")
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
			sleep(50)
			Send("{SPACE}")
			Send("{TAB}")
   EndIf
EndFunc