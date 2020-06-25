<#

.SYNOPSIS
Script to send events to an Event Grid Topic

.DESCRIPTION
The script sends events read from a json file to a specific Event Grid Topic.
Mandatory and optional fields:
	- TopicKey (Mandatory): Event Grid Topic Key.
	- TopicUri (Mandatory): Event Grid Topic Uri.
	- EventFile (Optional): Path to a json file with the event content. Defaulted to 'event.json'.
	- NumberEvents (Optional): Number of events to send. Use -1 for an infinite run.

.EXAMPLE

To send 10 events using a specific json file:
./SendEvent.ps1 -topicKey MyBeautifulTopicKey -topicUri https://my-amazing-topic.com/events -eventFile otherEvent.json -numberEvents 10

To send infinite events using a specific json file:
./SendEvent.ps1 -topicKey MyBeautifulTopicKey -topicUri https://my-amazing-topic.com/events -numberEvents -1

#>

Param(
[Parameter(Mandatory=$True)]  
[string]$topicKey,    
  
[Parameter(Mandatory=$True)]    
[string]$topicUri,

[string]$eventFile='event.json',

[int]$numberEvents
)    

For ($i=1; $i -le $numberEvents -Or $numberEvents -eq -1; $i++) {
	$rnd = Get-Random -Maximum 2000
	Start-Sleep -Milliseconds $rnd
	
	$eventContent = Get-Content -Raw -Path $eventFile | ConvertFrom-Json
	$eventContent.time = Get-Date -Format o
	
	$RequestParams = @{
		ContentType = 'application/cloudevents+json; charset=utf-8' 
		Body = $eventContent | ConvertTo-Json
		Method = 'Post'
		URI = $topicUri
		Headers = @{'aeg-sas-key'=$topicKey}
	}
	
	Invoke-RestMethod @RequestParams
}