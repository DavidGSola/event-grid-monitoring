$EventBody = Get-Content -Raw -Path 'event.json'

Write-Output $EventBody

$RequestParams = @{
    ContentType = 'application/cloudevents+json; charset=utf-8' 
    Body = $EventBody
    Method = 'Post'
    URI = 'https://ds-topic.northeurope-1.eventgrid.azure.net/api/events'
    Headers = @{'aeg-sas-key'='HDyOKOe21niWCLbKYLaI0RPmYDplrX32eRxPCqXUgBs='}
}

Invoke-RestMethod @RequestParams