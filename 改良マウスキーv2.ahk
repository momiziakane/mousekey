#Requires AutoHotkey v2.0
SendMode "Event"
SetNumLockState "AlwaysOn"
CoordMode("Mouse", "Screen")

velocity := [0,0]
accel := 0.5
displaymuki := 0
dispposition := 0
mauseswitch := 1


;テンキー
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



;ファンクションキー
F12::MsgBox "v1.46"
F1::KeyHistory()
F2::{
 global displaymuki
 changemsg:=["横","縦"]
 displaymuki := mod(displaymuki+1,2)
 MsgBox changemsg[displaymuki+1]
}
F3::{
 global dispposition
 ToolTip
 changemsg:=["非表示","表示"]
 dispposition := mod(dispposition+1,2)
 MsgBox changemsg[dispposition+1]
}
F4::{
 global mauseswitch
 ToolTip
 changemsg:=["無効化","有効化"]
 mauseswitch := mod(mauseswitch+1,2)
 MsgBox changemsg[mauseswitch+1] 
}




;カーソルワープ
NumpadAdd::{
 if displaymuki == 0
  MouseMove(1900,300)
 else if displaymuki == 1
  MouseMove(1080-300,1900)
}
NumpadEnter::{
 if displaymuki == 0
  MouseMove(300,800)
 if displaymuki == 1
  MouseMove(1080-800,300)
}

;終了　Ctrl+Alt+テンキー1
^!SC04F::{
  if MsgBox("終了しますか？", "確認", "Y/N") = "Yes"
   ExitApp()
}



SetTimer(Mouse, 10)




Mouse() {
 global accel,velocity,displaymuki,dispposition

;位置表示
if dispposition==1
 WatchCursor()

;計算
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
;移動
 if mauseswitch == 1
  if displaymuki == 0
   MouseMove(velocity[1], velocity[2], 0, "R")
  else if displaymuki == 1
   MouseMove(-velocity[2], velocity[1], 0, "R")
;減速、停止
 if velocity[1]**2 > 0.01
   velocity[1]*=0.95
 else
  velocity[1]:=0
 if velocity[2]**2 > 0.01
   velocity[2]*=0.95
 else
  velocity[2]:=0
}

;画面内のマウスポインタ―位置を確認するコード。
WatchCursor()
{
  xpos := 0
  ypos := 0
  CoordMode "Mouse", "Screen"
  MouseGetPos &xpos, &ypos
  ToolTip Format("X{1} Y{2}", xpos, ypos)
  Return
}
