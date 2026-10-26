param(
    [ValidateSet('All','1','2','3','4','5')][string]$Book = 'All',
    [ValidateSet('All','Interior','Cover','Proof')][string]$Target = 'All',
    [ValidateRange(0,999)][int]$Chapter = 0
)
$ErrorActionPreference = 'Stop'
if ($Chapter -gt 0 -and $Book -eq 'All') { throw 'Choose -Book 1..5 for a single-chapter build.' }
$folders = @('book-1-the-opportunity','book-2-the-offering','book-3-the-engine',
    'book-4-the-advantage','book-5-the-institution')
for ($index = 0; $index -lt $folders.Count; $index++) {
    if ($Book -ne 'All' -and [int]$Book -ne ($index + 1)) { continue }
    Write-Host ('Building ' + $folders[$index])
    & (Join-Path $PSScriptRoot ($folders[$index] + '/build.ps1')) -Target $Target -Chapter $Chapter
}
