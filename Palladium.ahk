#Warn
#NoEnv
SendMode, Input 
SetWorkingDir %A_ScriptDir%


; ========== CORE UPDATE ========== ;

;Ссылка для скачивания файла
Download_Core_URL =  https://github.com/Weoss/Palladium/archive/refs/heads/Core-Update.zip
;Название и формат, с которым файл сохранится
Download_Core_File = Core-Update.zip

;Запись текущей версии в переменную
FileReadLine, V_Core_Locale, %A_WorkingDir%\Core_Version.ini, 1
	if ErrorLevel = 1
	V_Core_Locale = 0

;Запись онлайн версии в переменную
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/Weoss/Palladium/Core-Update/Core_Version.ini", true)
whr.Send()
whr.WaitForResponse()
V_Core_From_Github := whr.ResponseText

;Обрезаем пустую строку с гитхаба и переносим в переменную для сравнения версий
StringTrimRight, V_Core_Online, V_Core_From_Github, 1

;=== Сравнение версий ===
;Если новая версия больше, чем текущая и не равна текущей = предложение скачать новую версию
if (V_Core_Locale < V_Core_Online and V_Core_Locale <> V_Core_Online)
{
    OnMessage(0x44, "OnMsgBox")
    MsgBox 0x41, Core Update, New version of Core available!`n`nCurrent Version: %V_Core_Locale% `nNew Version: %V_Core_Online%
    OnMessage(0x44, "")
    
    ;Если нажать кнопку Update "OK" = скачать новую версию
    IfMsgBox OK
    {
        UrlDownloadToFile, *0 %Download_Core_URL%, %Download_Core_File%
        
        Sleep, 3500
        
        ArcPath = %A_ScriptDir%\Core-Update.zip
        OutPath = %A_ScriptDir%

        Shell := ComObjCreate("Shell.Application")
        Items := Shell.NameSpace(ArcPath).Items
        Items.Filter(73952, "*")
        Shell.NameSpace(OutPath).CopyHere(Items, 16)
        
        FileCopy, %A_ScriptDir%/Palladium-Core-Update, %A_ScriptDir%, 1
        
        FileDelete, Core-Update.zip
        FileRemoveDir, Palladium-Core-Update, 1
        
        MsgBox 0x40040, Congratulations!, Your Core updated successful
        
        Goto Int_Update
    }
    ;Если нажать кнопку Cancel = закрыть программу
    Else IfMsgBox Cancel
    {
        ExitApp
    }

    OnMsgBox() {
        DetectHiddenWindows, On
        Process, Exist
        If (WinExist("ahk_class #32770 ahk_pid " . ErrorLevel)) {
            ControlSetText Button1, Update
            ControlSetText Button2, Close
        }
    }
}
;Если новой версии нет = проверка интерфейса









; ========== INTERFACE UPDATE ========== ;

Int_Update:

;Ссылка для скачивания файла
Download_Interface_URL =  https://github.com/mrbean271/1/archive/refs/heads/main.zip
;Название и формат, с которым файл сохранится
Download_Interface_File = InterfaceUpdate.zip

;Запись текущей версии в переменную
FileReadLine, V_Interface_Locale, %A_WorkingDir%\Interface\Interface_Version.ini, 1
	if ErrorLevel = 1
	V_Interface_Locale = 0

;Запись онлайн версии в переменную
whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
whr.Open("GET", "https://raw.githubusercontent.com/mrbean271/1/main/Interface_Version.ini", true)
whr.Send()
whr.WaitForResponse()
V_Interface_From_Github := whr.ResponseText

;Обрезаем пустую строку с гитхаба и переносим в переменную для сравнения версий
StringTrimRight, V_Interface_Online, V_Interface_From_Github, 1

;=== Сравнение версий ===
;Если новая версия больше, чем текущая и не равна текущей = предложение скачать новую версию
if (V_Interface_Locale < V_Interface_Online and V_Interface_Locale <> V_Interface_Online)
{
    OnMessage(0x44, "OnMsgBox")
    MsgBox 0x41, Interface Update, New version of Interface available!`n`nCurrent Version: %V_Interface_Locale% `nNew Version: %V_Interface_Online%
    OnMessage(0x44, "")
    
    ;Если нажать кнопку Update "OK" = скачать новую версию
    IfMsgBox OK
    {
        UrlDownloadToFile, *0 %Download_Interface_URL%, %Download_Interface_File%
        
        Sleep, 3500
        
        ArcPath = %A_ScriptDir%\InterfaceUpdate.zip
        OutPath = %A_ScriptDir%

        Shell := ComObjCreate("Shell.Application")
        Items := Shell.NameSpace(ArcPath).Items
        Items.Filter(73952, "*")
        Shell.NameSpace(OutPath).CopyHere(Items, 16)
        
        FileCopy, %A_ScriptDir%/1-main, %A_ScriptDir%/Interface, 1
        
        FileDelete, InterfaceUpdate.zip
        FileRemoveDir, 1-main, 1
        
        MsgBox 0x40040, Congratulations!, Your Interface updated successful
        
        ExitApp
    }
    ;Если нажать кнопку Cancel = закрыть программу
    Else IfMsgBox Cancel
    {
        ExitApp
    }

}
Else

ExitApp

