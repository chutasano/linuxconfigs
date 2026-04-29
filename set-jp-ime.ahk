; set-jp-ime.ahk
#NoTrayIcon
#SingleInstance Force
; Usage: set-jp-ime.ahk [on|off]

if (A_Args.Length = 0)
{
  ;WriteConsole("set-jp-ime.ahk: Err, no arg")
  ExitApp
}
else
{
  arg := StrLower(A_Args[1])
  if (arg = "on")
  {
    ;無変換: IME-on
      Send "{vk1Csc079}"
  }
  else if (arg = "off")
  {
    ;変換: IME-off
      Send "{vk1Dsc07B}"
  }
  else
  {
    ;WriteConsole("set-jp-ime.ahk: Err, bad arg")
  }
  ExitApp
}

