#Warn
#NoEnv
#SingleInstance
SendMode, Input 
SetWorkingDir %A_ScriptDir%
#NoTrayIcon

Path_Uncomplete := A_ScriptDir
StringTrimRight, Path_Complete, Path_Uncomplete, 21

FileCopy, %A_ScriptDir%, %Path_Complete%, 1
FileCopyDir, %A_ScriptDir%, %Path_Complete%, 1

FileDelete, %Path_Complete%/Palladium-Updater.ahk
FileDelete, %Path_Complete%/Core-Update.zip

FileRemoveDir, %Path_Complete%/Palladium-Core-Update, 1

MsgBox 0x40040, Congratulations!, Palladium updated successful!
Run, %Path_Complete%/Interface/Gui.exe