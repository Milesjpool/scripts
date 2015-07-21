$Script:initialDirectory = "D:\folder";
$Script:outputDirectory = "D:\otherFolder";
$Script:batchSize = 1000;
$Script:startingbatch = 1000000;

function Make-Batches
{
    $subfolder = 0;
    $batchNumber = $startingbatch -1;
    $files = CMD /c dir /b $initialDirectory;

    foreach ($item in $files)
    {
        If (0 -eq $subfolder % $batchSize)
            {
                $subfolder = 0;
                $batchNumber = $batchNumber + 1;
            }
        $batchDirectory = "$outputDirectory\batch$batchNumber";
        Ensure-Exists($batchDirectory);

        $folder = $item;
        $productDirectory = "$initialDirectory\$folder";

        copy-item $productDirectory $batchDirectory;
        $subfolder = $subfolder + 1;
    }
}

function Ensure-Exists($batchDirectory){
    if (!(Test-Path -path $batchDirectory))
    {
        New-Item $batchDirectory -Type Directory
    }
}

Make-Batches;