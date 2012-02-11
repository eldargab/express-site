rake res
$p = Start-Process node app.js -NoNewWindow -PassThru

$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = get-location
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $false

while($TRUE){
	$result = $watcher.WaitForChanged([System.IO.WatcherChangeTypes]::All, 100);
    if ($result.TimedOut) {
        continue
    }
    $p | Stop-Process
    rake res
    $p = Start-Process node app.js -NoNewWindow -PassThru
}
