function Invoke-FileActivity {
    try {
        $tempFile = "$env:TEMP\keepawake.txt"
        Set-Content -Path $tempFile -Value (Get-Date)
        Remove-Item -Path $tempFile -ErrorAction Stop
    }
    catch {
        Write-Host "Error performing file activity: $_"
        throw
    }
}

Write-Host "Starting file activity to prevent sleep. Press Ctrl+C to stop. (Note: May not prevent Teams away status.)"

try {
    while ($true) {
        # Perform file activity
        Invoke-FileActivity
        
        # Log action
        Write-Host "File activity performed. Waiting for next action..."
        
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
