# Autoriser l'exécution des scripts dans la session courante
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
Write-Host "[INFO] Politique d'exécution définie sur Bypass pour cette session." -ForegroundColor Cyan

# URL du script EmuDeck
$scriptUrl = 'https://raw.githubusercontent.com/EmuDeck/emudeck-we/main/install.ps1'
Write-Host "[INFO] Téléchargement du script depuis $scriptUrl..." -ForegroundColor Cyan

try {
    $webClient = New-Object System.Net.WebClient
    $scriptContent = $webClient.DownloadString($scriptUrl)
    Write-Host "[SUCCESS] Script téléchargé avec succès." -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Échec du téléchargement du script." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
    return
}

# Sauvegarde temporaire du script
$tempScriptPath = "$env:TEMP\emudeck-install.ps1"
try {
    Set-Content -Path $tempScriptPath -Value $scriptContent -Encoding UTF8
    Write-Host "[INFO] Script sauvegardé temporairement dans : $tempScriptPath" -ForegroundColor Cyan
} catch {
    Write-Host "[ERREUR] Impossible de sauvegarder le script." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
    return
}

# Exécution du script avec détails
Write-Host "[INFO] Lancement du script EmuDeck..." -ForegroundColor Cyan
try {
    & $tempScriptPath
    Write-Host "[SUCCESS] Script exécuté avec succès." -ForegroundColor Green
} catch {
    Write-Host "[ERREUR] Erreur pendant l'exécution du script." -ForegroundColor Red
    Write-Host $_.Exception.Message -ForegroundColor Yellow
}
