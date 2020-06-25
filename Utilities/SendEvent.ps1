param ($topicKey, $topicUri)

$RequestParams = @{
    ContentType = 'application/cloudevents+json; charset=utf-8' 
    Body = Get-Content -Raw -Path 'event.json'
    Method = 'Post'
    URI = $topicUri
    Headers = @{'aeg-sas-key'=$topicKey}
}

Invoke-RestMethod @RequestParams