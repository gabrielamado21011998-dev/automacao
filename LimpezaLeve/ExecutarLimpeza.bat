@echo off
title Limpeza Leve - Iniciando...
powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force"
powershell -ExecutionPolicy RemoteSigned -File "%~dp0LimpezaLeve.ps1"