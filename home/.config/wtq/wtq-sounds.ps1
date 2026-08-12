# wtq-sounds.ps1 - Play sounds on WTQ toggle events.
# Called by WTQ EventHooks; reads WTQ_EVENT_NAME and WTQ_APP_NAME env vars.

$event = $env:WTQ_EVENT_NAME
$app   = $env:WTQ_APP_NAME

$sounds = @{
    "WezTerm" = @{
        "AppToggledOn"  = "D:\sounds\windwaker\pause.mp3"
        "AppToggledOff" = "D:\sounds\windwaker\pause-close.mp3"
    }
    "Google Chrome" = @{
        "AppToggledOn"  = "D:\sounds\kingdom-hearts\pause.mp3"
        "AppToggledOff" = "D:\sounds\kingdom-hearts\pause-close.mp3"
    }
}

if (-not $sounds.ContainsKey($app)) { return }
if (-not $sounds[$app].ContainsKey($event)) { return }

$file = $sounds[$app][$event]
if (-not (Test-Path $file)) { return }

[System.Reflection.Assembly]::LoadWithPartialName("presentationCore") | Out-Null
$player = New-Object System.Windows.Media.MediaPlayer
$player.Open([Uri]$file)
$player.Play()
Start-Sleep -Milliseconds 3000
