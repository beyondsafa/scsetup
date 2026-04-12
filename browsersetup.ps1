# Current (incorrect):
if ($env:SCOOP_ROOT -ne $null) {
    $scoopRoot = $env:SCOOP_ROOT

# Should be:
if ($env:SCOOP -ne $null) {
    $scoopDir = $env:SCOOP
