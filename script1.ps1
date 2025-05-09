function Invoke-ScrollLock {
    try {
        $wshell = New-Object -ComObject wscript.shell
        $wshell.SendKeys("{SCROLLLOCK}")
        Start-Sleep -Milliseconds 50
        $wshell.SendKeys("{SCROLLLOCK}")
    }
    catch {
        Write-Host "Error simulating Scroll Lock: $_"
        throw
    }
}

Write-Host "Starting Scroll Lock toggle to prevent sleep/Teams away status. Press Ctrl+C to stop."

try {
    while ($true) {
        # Simulate Scroll Lock toggle
        Invoke-ScrollLock
        
        # Log action
        Write-Host "Scroll Lock toggled. Waiting for next action..."
        
        # Random interval between 4 and 12 seconds
        $sleepTime = Get-Random -Minimum 4000 -Maximum 12000
        Start-Sleep -Milliseconds $sleepTime
    }
}
catch {
    Write-Host "Script stopped: $_"
}
finally {
    Write-Host "Exiting script."
}
