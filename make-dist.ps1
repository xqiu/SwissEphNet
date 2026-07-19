function CopyFolder($project, $dest){
    $temp = mkdir $dest -Force
    Get-ChildItem -Recurse $project -Force -ErrorAction SilentlyContinue -File `
        | Where-Object {
            ($_.PSIsContainer -eq $false) `
            -and !($_.Name.Contains(".vshost.")) `
            -and !($_.Name.Contains("Tests")) `
            -and !($_.Name.EndsWith((".pdb"))) `
            `
        } `
        | ForEach-Object { Copy-Item $_.FullName -Destination $dest }
}

# Build directories
$temp = mkdir ./binaries -Force
$temp = mkdir ./binaries/net8.0 -Force
$temp = mkdir ./binaries/net10.0 -Force

$config = "Release"
$net8 = "bin/$config/net8.0"
$net10 = "bin/$config/net10.0"
$net8win = "bin/$config/net8.0-windows"
$net10win = "bin/$config/net10.0-windows"

# Copy SweMini
CopyFolder "./Programs/SweMini/$net8" "./binaries/net8.0/SweMini"
CopyFolder "./Programs/SweMini/$net10" "./binaries/net10.0/SweMini"

# Copy SweTest
CopyFolder "./Programs/SweTest/$net8" "./binaries/net8.0/SweTest"
CopyFolder "./Programs/SweTest/$net10" "./binaries/net10.0/SweTest"

# Copy SweWin
CopyFolder "./Programs/SweWin/$net8win" "./binaries/net8.0/SweWin"
CopyFolder "./Programs/SweWin/$net10win" "./binaries/net10.0/SweWin"
