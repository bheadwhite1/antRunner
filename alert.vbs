Dim Arg, message, titlebarMSG
Set Arg = WScript.Arguments

message = Arg(0)
titlebarMSG = Arg(1)

MsgBox (message), 65, (titlebarMSG)