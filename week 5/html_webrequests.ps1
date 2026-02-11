# Counts how many links are attatched to the webpage
$Scrapedpage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.12/ToBeScraped.html
$Scrapedpage.Links.Count

#Displays the links as HTML Elements
$Scrapedpage.Links

#Display only URL and text
$Scrapedpage.Links | Select-Object -Property outerText, href

#Get outer text of every element with the tag h2 
$th2=$Scrapedpage.ParsedHtml.body.getElementsByTagName("h2") | Select-Object -Property outertext 

$th2

#Print innerText of every div element that has the class as "div-1" 

$div1=$Scrapedpage.ParsedHtml.body.getElementsByTagName("div") |where { 
$_.getAttributeNode("class").Value -ilike "div-1"} | select innerText

$div1 