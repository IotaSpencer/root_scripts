#! /usr/bin/env ruby
require 'open3'
module CertBot
end
load '/root/root_scripts/do_certbot_xtra/find_creds', CertBot
domains = [
  '*.electrocode.net',
  '*.iotaspencer.me',
  '*.e-code.in',
  'e-code.in',
  'electrocode.net',
  'iotaspencer.me'
]
domain_lines = domains.map {|domain| "  -d '#{domain}'\\ \n"}
puts domain_lines

tmpl = <<~HEREDOC
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials #{credentials_file} \ 
HEREDOC
full_tmpl = tmpl + domain_lines.join('')
puts full_tmpl