require 'rubygems'
require 'tlsmail.rb'
require 'time'

content = <<EOF
From: ayodeleabejide@gmail.com
To: support@vas-consulting 
Subject: Wakanow CTI Restart
Date: #{Time.now.rfc2822}

CTI server successfully restarted

Regards,

Vas-support

EOF

Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', 'apps.vasconsulting@gmail.com', 'passw0rd$', :login) do |smtp|
      smtp.send_message(content, 'abejideayodele@gmail.com', ['support@vas-consulting.com'])
end
