# Function to check CPU usage
function Check-CPU {
    $cpuUsage = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    if ($cpuUsage -gt 85) {
        Write-Host "X High CPU usage: $cpuUsage%" -ForegroundColor Red
    } else {
        Write-Host "√ CPU usage: $cpuUsage%" -ForegroundColor Green
    }
}

# Function to check memory usage
function Check-Memory {
    $mem = Get-WmiObject win32_operatingsystem
    $memUsage = [math]::round((($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / $mem.TotalVisibleMemorySize) * 100, 2)
    if ($memUsage -gt 90) {
        Write-Host "X High memory usage: $memUsage%" -ForegroundColor Red
    } else {
        Write-Host "√ Memory usage: $memUsage%" -ForegroundColor Green
    }
}

# Function to check disk usage
function Check-Disk {
    $disk = Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'"
    $diskSize = $disk.Size
    $diskFreeSpace = $disk.FreeSpace
    $diskUsagePercent = [math]::round((($diskSize - $diskFreeSpace) / $diskSize) * 100, 2)
    if ($diskUsagePercent -gt 80) {
        Write-Host "X High disk usage: $diskUsagePercent%" -ForegroundColor Red
    } else {
        Write-Host "√ Disk usage: $diskUsagePercent%" -ForegroundColor Green
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