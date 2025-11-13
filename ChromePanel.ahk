#Requires AutoHotkey v2.0

; ----------------------------
; Variables to track state
; ----------------------------
isWindowActive := false
skip := true
wasPressed := false

; ----------------------------
; Timer to detect Right-Win key (LWin + Shift)
; ----------------------------
SetTimer CheckRightWin, 50
return

CheckRightWin() {
    global isWindowActive, skip, wasPressed

    ; Detect Right-Win key by combination Left-Win + Shift
    if GetKeyState("LWin", "P") && GetKeyState("Shift", "P") {
        if !wasPressed {
            wasPressed := true
            ; Call the toggle function
            ToggleApp()
        }
    } else {
        wasPressed := false
    }
}

; ----------------------------
; Function to toggle Chrome (or any app)
; ----------------------------
ToggleApp() {
    global isWindowActive, skip

    win := WinExist("ahk_exe chrome.exe")  ; Change chrome.exe to your app if needed
    if !win {  ; if Chrome does not exist
        Run("chrome.exe")
    }

    if (isWindowActive) {
        if WinExist(win) {
            WinMinimize(win)
        }
        skip := true
        isWindowActive := false
    } else {
        skip := false
    }

    if (!skip) {
        if !WinActive(win) && WinExist(win) {
            ; Window is not active or minimized → restore and activate it
            WinRestore(win)
            WinActivate(win)
            isWindowActive := true

            if win {
                ; Set always-on-top
                hWnd := win
                DllCall("SetWindowPos", "Ptr", hWnd, "Ptr", -1, "Int", 0, "Int", 0, "Int", 0, "Int", 0, "UInt", 3)
            }
        } else {
            ; Window is active → minimize it
            if WinExist(win) {
                WinMinimize(win)
            }
        }
    }
}
