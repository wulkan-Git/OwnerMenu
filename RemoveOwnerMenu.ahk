; Copyright (c) 2025 Владимир Wulk@n
; SPDX-License-Identifier: MIT
; Скрипт для удаления контекстного меню "Стать владельцем"
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

; Функция для безопасного удаления ключей реестра
SafeRegDelete(key) {
    try {
        RegDelete, %key%
        return true
    }
    catch e {
        return false
    }
}

; Удаление для всех файлов
SafeRegDelete("HKLM\SOFTWARE\Classes\*\shell\runas\command")
SafeRegDelete("HKLM\SOFTWARE\Classes\*\shell\runas")

; Удаление для папок
SafeRegDelete("HKLM\SOFTWARE\Classes\Directory\shell\runas\command")
SafeRegDelete("HKLM\SOFTWARE\Classes\Directory\shell\runas")

; Удаление для DLL файлов
SafeRegDelete("HKLM\SOFTWARE\Classes\dllfile\shell\runas\command")
SafeRegDelete("HKLM\SOFTWARE\Classes\dllfile\shell\runas")

; Удаление для EXE файлов
SafeRegDelete("HKLM\SOFTWARE\Classes\exefile\shell\runas2\command")
SafeRegDelete("HKLM\SOFTWARE\Classes\exefile\shell\runas2")

; Проверка успешности удаления
success := true
keys := ["*\shell\runas", "Directory\shell\runas", "dllfile\shell\runas", "exefile\shell\runas2"]
for i, key in keys
{
    RegRead, value, HKLM, SOFTWARE\Classes\%key%
    if !ErrorLevel
    {
        success := false
        break
    }
}

if success
    MsgBox, 64, Готово, Контекстное меню "Стать владельцем" успешно удалено!`n`nПерезапустите Проводник для применения изменений.
else
    MsgBox, 48, Ошибка, Не удалось полностью удалить контекстное меню.`nНекоторые элементы могли отсутствовать.

ExitApp