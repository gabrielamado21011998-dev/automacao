function Show-Menu {
    Clear-Host
    Write-Host " Limpeza Leve - Ferramenta de Otimizacao" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "1. Limpar arquivos temporarios"
    Write-Host "2. Limpar cache do Microsoft Edge"
    Write-Host "3. Limpar cache do Google Chrome"
    Write-Host "4. Finalizar processos não essenciais"
    Write-Host "5. Liberar memoria"
    Write-Host "6. Executar tudo"
    Write-Host "0. Sair"
    Write-Host ""
}

function Limpar-Temp {
    Write-Host " Limpando arquivos temporarios..." -ForegroundColor Yellow
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
}

function Limpar-CacheEdge {
    Write-Host " Limpando cache do Microsoft Edge..." -ForegroundColor Yellow
    $edgeCache = "$env:LOCALAPPDATA\Microsoft\Edge\User Data\Default\Cache"
    if (Test-Path $edgeCache) {
        Remove-Item -Path "$edgeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host " Cache do Edge limpo." -ForegroundColor Green
    } else {
        Write-Host " Pasta de cache do Edge nao encontrada." -ForegroundColor DarkYellow
    }
}

function Limpar-CacheChrome {
    Write-Host " Limpando cache do Google Chrome..." -ForegroundColor Yellow
    $chromeCache = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache"
    if (Test-Path $chromeCache) {
        Remove-Item -Path "$chromeCache\*" -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host " Cache do Chrome limpo." -ForegroundColor Green
    } else {
        Write-Host " Pasta de cache do Chrome nao encontrada." -ForegroundColor DarkYellow
    }
}

function Finalizar-Processos {
    Write-Host " Finalizando processos nao essenciais..." -ForegroundColor Yellow
    Get-Process | Where-Object { $_.Name -in @("OneDrive", "Teams") } | Stop-Process -Force -ErrorAction SilentlyContinue
}

function Liberar-Memoria {
    Write-Host " Liberando memoria..." -ForegroundColor Yellow
    [System.GC]::Collect()
}

do {
    Show-Menu
    $opcao = Read-Host "Escolha uma opcao"

    switch ($opcao) {
        "1" { Limpar-Temp }
        "2" { Limpar-CacheEdge }
        "3" { Limpar-CacheChrome }
        "4" { Finalizar-Processos }
        "5" { Liberar-Memoria }
        "6" {
            Limpar-Temp
            Limpar-CacheEdge
            Limpar-CacheChrome
            Finalizar-Processos
            Liberar-Memoria
        }
        "0" { Write-Host " Saindo..." -ForegroundColor Green }
        default { Write-Host " Opcao invalida. Tente novamente." -ForegroundColor Red }
    }

    if ($opcao -ne "0") {
        Write-Host ""
        Read-Host "Pressione Enter para continuar"
    }

} while ($opcao -ne "0")