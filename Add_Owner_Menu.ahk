; Copyright (c) 2025 Владимир Wulk@n
; SPDX-License-Identifier: MIT
; Скрипт для добавления контекстного меню "Стать владельцем"
; Требует запуска от имени администратора

#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

If not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}

; Для всех файлов
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\*\shell\runas,, Стать владельцем и получить полный доступ
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\*\shell\runas, Icon, imageres.dll,101
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\*\shell\runas, NoWorkingDirectory
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\*\shell\runas\command,, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\*\shell\runas\command, IsolatedCommand, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F

; Для папок
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\Directory\shell\runas,, Стать владельцем и получить полный доступ
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\Directory\shell\runas, Icon, imageres.dll,101
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\Directory\shell\runas, NoWorkingDirectory
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\Directory\shell\runas\command,, cmd.exe /c takeown /f `"`%1`" /r /d y `&`& icacls `"`%1`" /grant administrators:F /t
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\Directory\shell\runas\command, IsolatedCommand, cmd.exe /c takeown /f `"`%1`" /r /d y `&`& icacls `"`%1`" /grant administrators:F /t

; Для DLL файлов
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas,, Стать владельцем и получить полный доступ
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas, HasLUAShield
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas, Icon, imageres.dll,101
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas, NoWorkingDirectory
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas\command,, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\dllfile\shell\runas\command, IsolatedCommand, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F

; Для EXE файлов
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2,, Стать владельцем и получить полный доступ
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2, HasLUAShield
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2, Icon, imageres.dll,101
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2, NoWorkingDirectory
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2\command,, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F
RegWrite, REG_SZ, HKLM, SOFTWARE\Classes\exefile\shell\runas2\command, IsolatedCommand, cmd.exe /c takeown /f `"`%1`" `&`& icacls `"`%1`" /grant administrators:F

MsgBox, 64, Готово, Контекстное меню "Стать владельцем" успешно добавлено!`n`nПункт будет доступен в основном меню.
ExitApp