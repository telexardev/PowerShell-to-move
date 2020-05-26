param(
    [Parameter(Mandatory)][int]$monthsBack,
    [Parameter(Mandatory)][string]$sourceFolder,
    [Parameter(Mandatory)][string]$destinationFolder,
    [switch]$delete = $false,
    [switch]$excludeProcessing = $false,
    [switch]$excludePPK = $false
)

$refDate = (Get-Date).AddMonths(-$monthsBack)

$processingPattern = "*processing*"

if($excludePPK){
    $excludeExt = ("*.ppk")
}else{
    $excludeExt = ("")
}

$items = Get-ChildItem $sourceFolder -Recurse -Exclude $excludeExt | Where-Object {$_.LastWriteTime -lt $refDate} 

$items | ForEach-Object {

    $PathArray = $_.FullName.Replace($sourceFolder,"").ToString().Split('\') 

    $Folder = $destinationFolder

    if($delete){
        Write-Host "Deleting :"  + $_.FullName
        Remove-Item $_.FullName -Recurse -Force
    }else{
        
        for ($i=1; $i -lt $PathArray.length-1; $i++) {
            $Folder += "\" + $PathArray[$i]
            if (!(Test-Path $Folder)) {
                New-Item -ItemType directory -Path $Folder
            }
        }   


        $hasProcessing = $false

        if($excludeProcessing){
            if($_.FullName -like $processingPattern){
                $hasProcessing = $true
            }
        }

        if(!$hasProcessing){
            $NewPath = Join-Path $destinationFolder $_.FullName.Replace($sourceFolder,"")
            Write-Host "Moving : " + $NewPath
            Move-Item $_.FullName -Destination $NewPath -Force
        }


    }

}