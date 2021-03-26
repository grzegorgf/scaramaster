#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Add_Constants=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ProgressConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>

If $CmdLineRaw Then
	$title = $CmdLineRaw
Else
	$title = "Processing"
EndIf

$GUI = GUICreate($title, 220, 50, -1, -1, $WS_CAPTION,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW);BitOR($WS_EX_TOOLWINDOW,$WS_EX_WINDOWEDGE))

Local $Progress_1 = GUICtrlCreateProgress(10, 15, 200, 20, $PBS_MARQUEE)

GUISetState(@SW_SHOW)

_ProgressSetMarquee($Progress_1, $GUI)

While WinExists("SCARA Master","") <> 0

	sleep(100)
WEnd





; #AutoIt3Wrapper_Au3Check_Parameters=-d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
; #FUNCTION# =========================================================================================================
; Name...........: _ProgressSetMarquee
; Description ...: Starts/Stops the $PBS_MARQUEE effect on a GUICtrlCreateProgress() control.
; Syntax.........: _ProgressSetMarquee($iControl, $hHandle)
; Parameters ....: $iControl - A valid ProgressBar control ID.
;                  $hHandle - A valid GUI handle the ProgressBar is linked with.
; Requirement(s).: v3.3.0.0 or higher
; Return values .: Success - Returns a 2D Array with control ID and state of the ProgressBar. 0 = No Marquee effect Or 1 = Marquee effect.
; Author ........: guinness.
; Example........; Yes
;=====================================================================================================================
Func _ProgressSetMarquee($iControl, $hHandle)
    Local $bType = 0, $iColor = -1, $iIndex = -1
    If Not IsDeclared("Global_ProgressSetMarquee") Then Global $Global_ProgressSetMarquee[1][3] = [[0, 3]]

    For $A = 1 To $Global_ProgressSetMarquee[0][0]
        If @error Then ExitLoop
        If $Global_ProgressSetMarquee[$A][0] = $iControl Then
            $iIndex = $A
            $bType = $Global_ProgressSetMarquee[$iIndex][1]
            ExitLoop
        EndIf
    Next

    If $iIndex = -1 Then
        If $Global_ProgressSetMarquee[0][0] <= UBound($Global_ProgressSetMarquee, 1) + 1 Then ReDim $Global_ProgressSetMarquee[($Global_ProgressSetMarquee[0][0] + 1) * 2][$Global_ProgressSetMarquee[0][1]]
        $Global_ProgressSetMarquee[0][0] += 1
        $iIndex = $Global_ProgressSetMarquee[0][0]
        $Global_ProgressSetMarquee[$iIndex][0] = $iControl
        $Global_ProgressSetMarquee[$iIndex][1] = $bType
        $Global_ProgressSetMarquee[$iIndex][2] = $iColor
    EndIf

    Local $hControl = GUICtrlGetHandle($Global_ProgressSetMarquee[$iIndex][0]), $aControlGetPos = ControlGetPos($hHandle, "", $Global_ProgressSetMarquee[$iIndex][0])
    Local $aStyle = DllCall("user32.dll", "long", "GetWindowLong", "hwnd", $hControl, "int", 0xFFFFFFF0)
    Local $aExStyle = DllCall("user32.dll", "long", "GetWindowLong", "hwnd", $hControl, "int", 0xFFFFFFEC)
    If $aStyle[0] <> 1342308360 Then
        GUICtrlDelete($Global_ProgressSetMarquee[$iIndex][0])
        $iControl = GUICtrlCreateProgress($aControlGetPos[0], $aControlGetPos[1], $aControlGetPos[2], $aControlGetPos[3], 0x0008, $aExStyle[0]) ; 0x0008
        $hControl = GUICtrlGetHandle($iControl)
        If $Global_ProgressSetMarquee[$iIndex][2] <> -1 Then
            DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hControl, "wstr", 0, "wstr", 0)
            GUICtrlSetColor($iControl, $Global_ProgressSetMarquee[$iIndex][2])
        EndIf
        $Global_ProgressSetMarquee[$iIndex][0] = $iControl
    EndIf

    Switch $Global_ProgressSetMarquee[$iIndex][1]
        Case 1
            $bType = False
        Case Else
            $bType = True
    EndSwitch

    DllCall("user32.dll", "lresult", "SendMessageW", "hwnd", $hControl, "uint", 1034, "wparam", $bType, "lparam", 50)
    If @error Then $Global_ProgressSetMarquee[$iIndex][1] = 1
    If $Global_ProgressSetMarquee[$iIndex][1] = 1 Then
        GUICtrlDelete($Global_ProgressSetMarquee[$iIndex][0])
        $iControl = GUICtrlCreateProgress($aControlGetPos[0], $aControlGetPos[1], $aControlGetPos[2], $aControlGetPos[3], 0x0008, $aExStyle[0]) ; 0x0008
        If $Global_ProgressSetMarquee[$iIndex][2] <> -1 Then
            DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle($iControl), "wstr", 0, "wstr", 0)
            GUICtrlSetColor($iControl, $Global_ProgressSetMarquee[$iIndex][2])
        EndIf
        $Global_ProgressSetMarquee[$iIndex][0] = $iControl
        $Global_ProgressSetMarquee[$iIndex][1] = 0
        Return 0
    EndIf
    $Global_ProgressSetMarquee[$iIndex][1] = 1
    Return 1
EndFunc   ;==>_ProgressSetMarquee

; #FUNCTION# =========================================================================================================
; Name...........: _ProgressSetTheme
; Description ...: Sets a 'themed' ProgressBar with the ability to change the color of the ProgressBar.
; Syntax.........: _ProgressSetTheme([$iControl, [$bThemeColor]])
; Parameters ....: $iControl - [optional] A valid ProgressBar control ID. Default = -1 (last control ID)
;                  $hHandle - [optional] A valid Hex color value. Default = 0x24D245
; Requirement(s).: v3.3.0.0 or higher
; Return values .: Success - Returns a value from the 'SetWindowTheme' DLL call.
;                  Failure - Returns 0 with @extended set as 1.
; Author ........: guinness.
; Example........; Yes
;=====================================================================================================================
Func _ProgressSetTheme($iControl = -1, $bThemeColor = 0x24D245)
    Local $bType = 0, $iColor = $bThemeColor, $iIndex = -1, $hControl = GUICtrlGetHandle($iControl)
    If Not IsDeclared("Global_ProgressSetMarquee") Then Global $Global_ProgressSetMarquee[1][3] = [[0, 3]]

    $iControl = DllCall("user32.dll", "int", "GetDlgCtrlID", "hwnd", $hControl)
    If @error Then Return SetError(1, 1, 0)
    $iControl = $iControl[0]

    For $A = 1 To $Global_ProgressSetMarquee[0][0]
        If @error Then ExitLoop
        If $Global_ProgressSetMarquee[$A][0] = $iControl Then
            If $Global_ProgressSetMarquee[$A][1] = 1 Then Return SetError(1, 1, 0) ; Marquee is already running.
            $iIndex = $A
            $bType = $Global_ProgressSetMarquee[$iIndex][1]
            ExitLoop
        EndIf
    Next

    If $iIndex = -1 Then
        If $Global_ProgressSetMarquee[0][0] <= UBound($Global_ProgressSetMarquee, 1) + 1 Then ReDim $Global_ProgressSetMarquee[($Global_ProgressSetMarquee[0][0] + 1) * 2][$Global_ProgressSetMarquee[0][1]]
        $Global_ProgressSetMarquee[0][0] += 1
        $iIndex = $Global_ProgressSetMarquee[0][0]
        $Global_ProgressSetMarquee[$iIndex][0] = $iControl
        $Global_ProgressSetMarquee[$iIndex][1] = $bType
        $Global_ProgressSetMarquee[$iIndex][2] = $iColor
    EndIf

    Local $aReturn = DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", $hControl, "wstr", 0, "wstr", 0)
    If @error Then Return SetError(1, 1, 0)
    GUICtrlSetColor($iControl, $Global_ProgressSetMarquee[$iIndex][2])
    Return $aReturn[0]
EndFunc   ;==>_ProgressSetTheme