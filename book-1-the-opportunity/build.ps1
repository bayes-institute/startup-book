param(
    [ValidateSet('All','Interior','Cover','Proof')][string]$Target = 'All',
    [ValidateRange(0,999)][int]$Chapter = 0
)
$ErrorActionPreference = 'Stop'
$bookRoot = $PSScriptRoot
$mainFiles = @(Get-ChildItem -LiteralPath $bookRoot -Filter 'the-*.tex' -File)
if ($mainFiles.Count -ne 1) { throw 'Expected one the-*.tex manuscript in this book folder.' }
$mainFile = $mainFiles[0]
$stem = $mainFile.BaseName
$chapterNumbers = @([regex]::Matches((Get-Content -LiteralPath $mainFile.FullName -Raw), '\\BIIncludeChapter\{(\d+)\}') |
    ForEach-Object { [int]$_.Groups[1].Value })
if ($Chapter -gt 0 -and ($Target -notin @('All','Interior') -or $Chapter -notin $chapterNumbers)) {
    throw 'Select an existing local chapter number and use -Target Interior.'
}
$cache = Join-Path $bookRoot '.cache'
$texOut = Join-Path $cache 'tex'
$outputDirectory = Join-Path $bookRoot 'build'
$dependencyDirectory = Join-Path $cache 'python-packages'
New-Item -ItemType Directory -Path $texOut,$outputDirectory -Force | Out-Null

# Every book can bootstrap its own compiler. No parent repository is consulted.
$compiler = Join-Path $bookRoot 'tools/tectonic/tectonic.exe'
if (-not (Test-Path -LiteralPath $compiler)) {
    $installedCompiler = Get-Command tectonic -ErrorAction SilentlyContinue
    if ($installedCompiler) { $compiler = $installedCompiler.Source }
    else {
        $archive = Join-Path $cache 'tectonic-0.17.0.zip'
        $expectedHash = 'F61CE51F0B0ADE1015B7DE7EF368541C5424E9756ECBD0D7AF97D6D48030845F'
        $downloadUrl = 'https://github.com/tectonic-typesetting/tectonic/releases/download/tectonic%400.17.0/tectonic-0.17.0-x86_64-pc-windows-msvc.zip'
        if (-not (Test-Path -LiteralPath $archive) -or (Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $expectedHash) {
            Write-Host 'Downloading the pinned Windows Tectonic compiler for this book...'
            Invoke-WebRequest -UseBasicParsing -Uri $downloadUrl -OutFile $archive
        }
        if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $expectedHash) {
            throw 'The downloaded compiler archive did not match the pinned checksum.'
        }
        Expand-Archive -LiteralPath $archive -DestinationPath (Join-Path $bookRoot 'tools/tectonic') -Force
        if (-not (Test-Path -LiteralPath $compiler)) { throw 'Tectonic installation did not produce tectonic.exe.' }
    }
}
$pythonCommand = Get-Command python -ErrorAction SilentlyContinue
if (-not $pythonCommand) { throw 'Install Python 3.10 or newer, enable its PATH option, and run this build again.' }
$python = $pythonCommand.Source
& $python -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)'
if ($LASTEXITCODE -ne 0) { throw 'Python 3.10 or newer is required.' }
$probe = "import sys,importlib.util;sys.path.insert(0,sys.argv[1]);print('ready' if importlib.util.find_spec('pymupdf') else 'missing')"
$dependencyStatus = & $python -c $probe $dependencyDirectory
if ($dependencyStatus -ne 'ready') {
    & $python -m pip install --disable-pip-version-check --no-warn-script-location --target $dependencyDirectory -r (Join-Path $bookRoot 'requirements-build.txt')
    if ($LASTEXITCODE -ne 0) { throw 'Could not install the local PDF build dependency.' }
}
$previousFontConfig = $env:FONTCONFIG_FILE
Push-Location $bookRoot
try {
    $fontDirectory = [System.Security.SecurityElement]::Escape((Join-Path $bookRoot 'fonts').Replace('\','/'))
    $fontCache = [System.Security.SecurityElement]::Escape((Join-Path $cache 'font-cache').Replace('\','/'))
    New-Item -ItemType Directory -Path (Join-Path $cache 'font-cache') -Force | Out-Null
    $fontConfig = Join-Path $cache 'fontconfig.xml'
    "<?xml version='1.0'?><fontconfig><dir>$fontDirectory</dir><cachedir>$fontCache</cachedir></fontconfig>" |
        Set-Content -LiteralPath $fontConfig -Encoding UTF8
    $env:FONTCONFIG_FILE = $fontConfig
    & $python tools/build_support.py prepare
    if ($LASTEXITCODE -ne 0) { throw 'Vector asset preparation failed.' }
    $jobs = @()
    if ($Target -in @('All','Interior')) {
        if ($Chapter -gt 0) {
            ('\def\BIOnlyChapter{' + $Chapter + '}\input{' + $mainFile.Name + '}') |
                & $compiler --keep-logs --keep-intermediates --outdir $texOut -
            if ($LASTEXITCODE -ne 0) { throw 'Chapter compilation failed.' }
            $name = $stem + ('-chapter-{0:D2}.pdf' -f $Chapter)
            $sourcePdf = Join-Path $texOut 'texput.pdf'
            $log = Join-Path $texOut 'texput.log'
        } else {
            & $compiler --keep-logs --keep-intermediates --outdir $texOut $mainFile.Name
            if ($LASTEXITCODE -ne 0) { throw 'Interior compilation failed.' }
            $name = $stem + '.pdf'
            $sourcePdf = Join-Path $texOut $name
            $log = Join-Path $texOut ($stem + '.log')
        }
        $jobs += @{path=$sourcePdf; kind='interior'; log=$log; output=(Join-Path $outputDirectory $name)}
    }
    if ($Chapter -eq 0 -and $Target -in @('All','Cover')) {
        & $compiler --keep-logs --outdir $texOut cover.tex
        if ($LASTEXITCODE -ne 0) { throw 'Cover compilation failed.' }
        $jobs += @{path=(Join-Path $texOut 'cover.pdf'); kind='cover'; log=(Join-Path $texOut 'cover.log');
            output=(Join-Path $outputDirectory ($stem + '-front-cover.pdf'))}
    }
    if ($Target -eq 'Proof') {
        & $compiler --keep-logs --keep-intermediates --outdir $texOut design-proof.tex
        if ($LASTEXITCODE -ne 0) { throw 'Design specimen compilation failed.' }
        $jobs += @{path=(Join-Path $texOut 'design-proof.pdf'); kind='interior'; log=(Join-Path $texOut 'design-proof.log');
            output=(Join-Path $outputDirectory 'design-proof.pdf')}
    }
    $manifest = Join-Path $cache 'last-build.json'
    ConvertTo-Json -InputObject @($jobs) -Depth 4 | Set-Content -LiteralPath $manifest -Encoding UTF8
    & $python tools/build_support.py check $manifest
    if ($LASTEXITCODE -ne 0) { throw 'Print checks failed. Inspect .cache/print-checks.json.' }
    foreach ($job in $jobs) {
        Copy-Item -LiteralPath $job.path -Destination $job.output -Force
        Write-Host ('Ready: ' + $job.output)
    }
} finally {
    $env:FONTCONFIG_FILE = $previousFontConfig
    Pop-Location
}
