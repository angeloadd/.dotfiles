<?php

declare(strict_types=1);

function getNewVersionByStrategy(string $strategy, string $breaking, string $minor, string $patch): string
{
    $newBreaking = 0;
    $newMinor = 0;
    $newPatch = 0;

    switch ($strategy) {
        case 'b':
            $newBreaking = (int) $breaking;
            ++$newBreaking;
            break;
        case 'm':
            $newMinor = (int) $minor;
            ++$newMinor;
            $newBreaking = (int) $breaking;
            break;
        case 'p':
            $newPatch = (int) $patch;
            ++$newPatch;
            $newBreaking = (int) $breaking;
            $newMinor = (int) $minor;
            break;
        default:
            break;
    }

    return sprintf('version: v%d.%d.%d', $newBreaking, $newMinor, $newPatch);
}

function getFileNamesList(string $directoryName): array
{
    $baseDirContent = glob($directoryName.'/*');
    $fileNamesList = [];

    foreach ($baseDirContent as $fileOrDir) {
        if (is_dir($fileOrDir)) {
            $subDir = glob($fileOrDir.'/*');
            foreach ($subDir as $subFile) {
                $fileNamesList[] = $subFile;
            }
        } else {
            $fileNamesList[] = $fileOrDir;
        }
    }

    return $fileNamesList;
}

function getCurrentVersionToArray(string $apiYamlFile): array
{
    $fileContentSplitByLine = file($apiYamlFile);

    $versionLineSplitByV = explode(
        'v',
        current(
            array_filter(
            $fileContentSplitByLine,
            static function (string $line): int|bool {
                return preg_match('/\sversion: v\d+.\d+.\d+/', $line);
            }
            )
        )
    );

    $versionString = end($versionLineSplitByV);
    return explode('.', $versionString);
}

$baseDir = getcwd().'/Contracts/Providing';
$bumpStrategy = $argv[1] ?? 'not_valid';
$providedVersion = $argv[2] ?? 'not_valid_version';

$fileNames = getFileNamesList($baseDir);
$versionToArray = getCurrentVersionToArray(end($fileNames));

$newVersion = match ($bumpStrategy){
    'b', 'p', 'm' => getNewVersionByStrategy($bumpStrategy, ...$versionToArray),
    '-v' => 'version: v'.$providedVersion,
    'not_valid' => throw new Exception('You have to specify an argument between b, m or p'),
    'not_valid_version' => throw new Exception('You have to specify an argument for -v option'),
    default => throw new InvalidArgumentException('The argument specified is not valid. You have to specify an argument between b, m or p'),
};

foreach ($fileNames as $fileName) {
    $fCont = file_get_contents($fileName);
    $strippedVersion = trim($newVersion);
    $newC = preg_replace('/version: v\d+.\d+.\d+/', $strippedVersion, $fCont);
    file_put_contents($fileName, $newC);
}

echo 'bumping to '. $newVersion."\n";
