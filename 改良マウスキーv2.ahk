SendMode "Event"
SetNumLockState "AlwaysOn"
CoordMode("Mouse", "Screen")

velocity := [0,0]
accel := 0.5

;numpad1
*SC04F::return

;numpad2
*SC050::Send "{Blind}{WheelUp}"

;numpad3
*SC051::Send "{Blind}{WheelDown}"

;numpad4
*SC04B::return

;numpad5
*SC04C::return

;numpad6
*SC04D::return

;numpad7
*SC047::
{
    if GetKeyState("Shift","P")
        Send "+{Click}"
    else
        Send "{Blind}{LButton Down}"
}

*SC047 up::Send "{Blind}{LButton Up}"

;numpad8
*SC048::return

;numpad9
*SC049::Send "{Blind}{RButton Down}"
*SC049 up::Send "{Blind}{RButton Up}"

;numpad0
*SC052::return

F12::MsgBox "v1.45"
F1::KeyHistory()

NumpadAdd::MouseMove(1900,300)
NumpadEnter::MouseMove(300,800)


^!SC04F::{
  if MsgBox("終了しますか？", "確認", "Y/N") = "Yes"
   ExitApp()
}



SetTimer(Mouse, 10)



Mouse() {
 global accel ,velocity
 if GetKeyState("Numpad8", "P")
  velocity[2] -= accel
 else if GetKeyState("Numpad5", "P")
  velocity[2] += accel
 else 
  velocity[2] := 0
 if GetKeyState("Numpad4", "P")
  velocity[1] -= accel
 else if GetKeyState("Numpad6", "P")
  velocity[1] += accel
 else 
  velocity[1] := 0
 MouseMove(velocity[1], velocity[2], 0, "R")
 if velocity[1]**2 > 0.01
   velocity[1]*=0.95
 else
  velocity[1]:=0
 if velocity[2]**2 > 0.01
   velocity[2]*=0.95
 else
  velocity[2]:=0
}

;画面内のマウスポインタ―位置を確認するコード。あると便利。なんかめちゃ重いけど。
WatchCursor()
{
  xpos := 0
  ypos := 0
  CoordMode "Mouse", "Screen"
  MouseGetPos &xpos, &ypos
  ToolTip Format("X{1} Y{2}", xpos, ypos)
  Return
}
