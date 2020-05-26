# PowerShell-to-move

## Usage 
.\backup_script.ps1 -monthsBack <Months> -sourceFolder "<Path>" -destinationFolder "<Path>" 

Path => Absolute path to source and destination folder
Months => Integer number of the Months go behind

## Optiona Flags
-delete => Delete files not move
-excludeProcessing => Exlcude processing folder
-excludePPK => exclude .ppk ext files

## Example Usage
.\backup_script.ps1 -monthsBack <Months> -sourceFolder "<Path>" -destinationFolder "<Path>"  -excludePPK -delete

