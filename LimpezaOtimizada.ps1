# Verifica se está em modo administrador
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $IsAdmin) {
    Write-Host "🔐 Elevando privilégios para administrador no domínio..." -ForegroundColor Yellow

    $scriptPath = $MyInvocation.MyCommand.Definition
    $arguments = "-ExecutionPolicy Bypass -File `"$scriptPath`""

    # Força execução como administrador
    Start-Process powershell.exe -ArgumentList $arguments -Verb RunAs
    exit
}

Write-Host "✅ Privilégios elevados confirmados." -ForegroundColor Green

# 🧹 Limpeza e otimização
Write-Host "🔧 Iniciando limpeza e otimização..." -ForegroundColor Cyan

# Limpar arquivos temporários
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

# Limpar cache DNS
Clear-DnsClientCache

# Otimizar disco
Optimize-Volume -DriveLetter C -ReTrim -Verbose
Optimize-Volume -DriveLetter C -Defrag -Verbose

# Verificação rápida de vírus
Start-MpScan -ScanType QuickScan

Write-Host "🏁 Limpeza e otimização concluída!" -ForegroundColor Green