#POC
#Invoke-WebRequest -Uri http://localhost:8080 -ContentType "application/json" -Body '{"thing":"value", "thing2":"Value2"}' -Method Post
function Send-CSVToLogstash {
    param(
        $CSVFilePath
    )
    $CSVFileRecords = Import-Csv -Delimiter ',' -Path $CSVFilePath
    $CSVFileRecords | % {
        $progressPreference = 'silentlyContinue'
        $(Invoke-WebRequest -Uri http://localhost:8080 -ContentType "application/json" -Method Post -Body $($_ | ConvertTo-Json) )| Out-Null
        $progressPreference = 'Continue'
    }
}

#Send-CSVToLogstash -CSVFilePath "C:\Users\cmagnuson\Desktop\Operations reporting\DC Report 2016.01.29 0500 DC Light sample.csv"
#Send-CSVToLogstash -CSVFilePath "C:\Users\cmagnuson\Desktop\Operations reporting\DC Report 2016.01.29 0500 DC Light.csv"