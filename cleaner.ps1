$file = (New-Guid).ToString()
$index = 0
$text = "0000000000"

for ($i = 0; $i -lt 40; $i++)
{
    $text += $text
}

Write-Output $text.Length.ToString('###,###,###,###,###.##')

# $text | Out-File $file

$streamWriter = new-object system.IO.StreamWriter($file, $true)
while($true)
{
    $index = 0;

    try {
    
        while($true)
        {
            $streamWriter.WriteLine($text)
            $streamWriter.Flush()
            Start-Sleep -Seconds 0.1
            $index++
            Write-Output "#" $index " [" $text.Length.ToString('###,###,###.##') "]"
        }
    # $text | Out-File $file -Append

    }
    catch
    {
        if($text.Length/2 -gt 1)
        {
            $text = $text.SubString(0, $text.length/2)
        }
        else
        {
            break
        }

    }
    finally
    {
    }
}
$streamWriter.Close()
