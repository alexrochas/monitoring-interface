# Monitoring Interface
> Attempt to "BFF" a healthcheck API

## How-to

In order to be the most simple as possible, all the user have to do is implements new "scripts" in the folder /scripts
and hit the API to run them.

This way, all healthcheck implementations are agnostic (apart from the need to be in Ruby).

Example:

```ruby
require 'net/http'
require 'uri'

uri = URI.parse('https://nt-cal-necs1.novatel.com:7000/soap/INovAtelPartnerM2M')
header = {'Content-Type': 'text/xml'}
http = Net::HTTP.new(uri.host, uri.port, :read_timeout=>500)
http.use_ssl = true
body = '
  <soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:NovAtelPartnerM2MIntf-INovAtelPartnerM2M">
     <soapenv:Header/>
     <soapenv:Body>
        <urn:TestConnection soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
           <EchoMessage xsi:type="xsd:string">Echo Test</EchoMessage>
        </urn:TestConnection>
     </soapenv:Body>
  </soapenv:Envelope>
'

response = http.post(uri.path, body, header)
raise 'Service error' unless response.code != 200

'{
  "status":"green"
}'
```

## Meta

Alex Rocha - [about.me](http://about.me/alex.rochas)
