#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

modnum=1
turbo=0
profolder=NaN
logfolder=NaN
iniloc=%A_AppData%\KTANE Helper\config.ini

IniRead, profolder, %iniloc%,KTANE Folders,profolder
IniRead, logfolder, %iniloc%,KTANE Folders,logfolder
if (logfolder == "ERROR" or profolder == "ERROR")
GoSub GetIni

Boo:
MsgBox, Welcome to KTaNE Twitch Plays Helper by Pelia!`n`nThe script should help you type commands easier. It also features "hotstrings", executed by simply typing the word and pressing space. When a command expects a number, simply type it and press space after the command is called.`n`nA list of possible commands is below:`n`nCtrl-T (take) - claims a module of a given number and displays its manual link`nCtrl-Shift-T (leave) - unclaims a module of a given number`nCtrl-F (flip) - triggers !bomb flip`nCtrl-E (edge) - triggers !edgework`nCtrl-Alt-E (edgeget) - triggers !bomb edgework 45`nCtrl-Shift-E (edgeset) - Takes your clipboard content and puts it into a !edgework command to set edgework for other players.`nCtrl-H - Halts any input to the script. Press again to undo`nAlt-H - Turbo Mode. Some commands are delayed as an anti-anti-spam measure. This toggles the delay`nCtrl-Alt-X - Terminates script entirely (unless it is paused)`n`nHere are some helpers for KTANE itself, their usage requires to store folder paths in an .ini file in your AppData/Roaming folder. Lack of it causes these commands to simply play a sound.`n(exprofs) - opens the folder containing KTANE Mod Profiles`n(thelog) - opens the folder with the KTANE's output_log`n`nThis screen can be summoned again by pressing Ctrl-F1.
Return

Turbo:
If !turbo
Sleep 1500
Return

!H::
turbo := !turbo
Return

::exprofs::
if (profolder != "NaN")
Run %profolder%
Else SoundPlay, *48
Return

::thelog::
if (logfolder != "NaN")
Run %logfolder%
Else SoundPlay, *48
Return

^F1::
GoSub Boo
Return


^H::
Suspend ,Toggle
Return

^!X::
ExitApp, 0
Return

::take::
^T::
Input ,modnum,I,{Space},
Send {!}%modnum% claim{Enter}
GoSub Turbo
Send {!}%modnum% manual{Enter}
Return

::leave::
^+T::
Input ,modnum,I,{Space},
Send {!}%modnum% unclaim{Enter}
Return

::flip::
^F::
Send {!}bomb flip{Enter}
Return

::edge::
^E::
Send {!}edgework{Enter}
Return

::edgeget::
^!E::
Send {!}bomb edgework 45{Enter}
Return


::edgeset::
^+E::
Send {!}edgework %clipboard%{Enter}
Return

GetIni:
MsgBox, 49, Settings not found, It seems that the .ini file is missing or corrupted! You can set the KTANE Mod Profile folder and the Output Log folders again, and a new .ini will be made. Otherwise, some commands will not function.
IfMsgBox, Cancel
{profolder=NaN
logfolder=NaN
}
Else IfMsgBox, OK
{
FileSelectFolder, profolder,,2,Choose the KTANE Mod Profiles folder
FileSelectFolder, logfolder,,2,Choose the KTANE Output Log folder
IniWrite, %profolder%,%iniloc%,KTANE Folders,profolder
IniWrite, %logfolder%,%iniloc%,KTANE FOlders,logfolder
}
Return


