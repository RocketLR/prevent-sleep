Add-Type @"
    using System;
    using System.Runtime.InteropServices;
    public class KeyboardSimulator {
        [DllImport("user32.dll")]
        public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, int dwExtraInfo);
        public const byte VK_SCROLL = 0x91; // Scroll Lock key
        public const uint KEYEVENTF_KEYUP = 0x0002;
        public static void ToggleScrollLock() {
            keybd_event(VK_SCROLL, 0, 0, 0); // Press Scroll Lock
            keybd_event(VK_SCROLL, 0, KEYEVENTF_KEYUP, 0); // Release Scroll Lock
        }
    }
"@

function Invoke-ScrollLock {
    try {
        [KeyboardSimulator]::ToggleScrollLock()
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
