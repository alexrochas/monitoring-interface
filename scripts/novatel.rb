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
