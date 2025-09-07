# Function to check CPU usage
function Check-CPU {
    $cpuUsage = Get-WmiObject win32_processor | Measure-Object -Property LoadPercentage -Average | Select-Object -ExpandProperty Average
    Write-Output "CPU Usage: $cpuUsage%"
}

# Function to check memory usage
function Check-Memory {
    $mem = Get-WmiObject win32_operatingsystem
    $memUsage = [math]::round((($mem.TotalVisibleMemorySize - $mem.FreePhysicalMemory) / $mem.TotalVisibleMemorySize) * 100, 2)
    Write-Output "Memory Usage: $memUsage%"
}

# Function to check disk usage
function Check-Disk {
    $diskUsage = Get-WmiObject win32_logicaldisk -Filter "DeviceID='C:'" | Select-Object -ExpandProperty Size,FreeSpace
    $diskUsagePercent = [math]::round((($diskUsage.Size - $diskUsage.FreeSpace) / $diskUsage.Size) * 100, 2)
    Write-Output "Disk Usage: $diskUsagePercent%"
}

# Main function
function Main {
    Check-CPU
    Check-Memory
    Check-Disk
}

# Entry point
Main