# Function to check CPU usage
function Check-CPU {
    $cpuUsage = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    if ($cpuUsage -gt 85) {
        Write-Host "[X] High CPU usage: $cpuUsage%" -ForegroundColor Red
        "[X] High CPU usage: $cpuUsage%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    } else {
        Write-Host "[OK] CPU usage: $cpuUsage%" -ForegroundColor Green
        "[OK] CPU usage: $cpuUsage%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    }
}

# Function to check memory usage
function Check-Memory {
    $mem = Get-WmiObject win32_operatingsystem
    $memUsage = [math]::round((($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / $mem.TotalVisibleMemorySize) * 100, 2)
    if ($memUsage -gt 90) {
        Write-Host "[X] High memory usage: $memUsage%" -ForegroundColor Red
        "[X] High memory usage: $memUsage%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    } else {
        Write-Host "[OK] Memory usage: $memUsage%" -ForegroundColor Green
        "[OK] Memory usage: $memUsage%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    }
}

# Function to check disk usage
function Check-Disk {
    $disk = Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'"
    $diskSize = $disk.Size
    $diskFreeSpace = $disk.FreeSpace
    $diskUsagePercent = [math]::round((($diskSize - $diskFreeSpace) / $diskSize) * 100, 2)
    if ($diskUsagePercent -gt 80) {
        Write-Host "[X] High disk usage: $diskUsagePercent%" -ForegroundColor Red
        "[X] High disk usage: $diskUsagePercent%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    } else {
        Write-Host "[OK] Disk usage: $diskUsagePercent%" -ForegroundColor Green
        "[OK] Disk usage: $diskUsagePercent%" | Out-File -FilePath "C:\Users\rhoe\Documents\CSTU\CSE604\Github\vm-health-check\docs\health_check.log" -Append
    }
}

# Function to explain the health status
function Explain {
    Write-Host "This script checks the health status of your VM by monitoring CPU, memory, and disk usage."
    Write-Host "CPU usage above 85% is considered high and may affect performance."
    Write-Host "Memory usage above 90% indicates memory pressure and may lead to performance issues."
    Write-Host "Disk usage above 80% is considered high and may affect system stability."
}

# Main function
function Main {
    while ($true) {
        Clear-Host
        Check-CPU
        Check-Memory
        Check-Disk
        Start-Sleep -Seconds 5
    }
}

# Argument parsing
param (
    [string]$Mode
)

if ($Mode -eq "--explain") {
    Explain
} else {
    Main
}