#! /usr/bin/env ruby
require 'open3'
require 'etc'

if Etc.getlogin == 'root'
  require '/root/root_scripts/do_certbot_xtra/find_creds'
else
  require '/home/ken/root_scripts/do_certbot_xtra/find_creds'
end
credentials_file = CertBot::Creds.new.get_creds_file
domains = [
  '*.electrocode.net',
  '*.iotaspencer.me',
  '*.e-code.in',
  'e-code.in',
  'electrocode.net',
  'iotaspencer.me'
]
domain_lines = domains.map {|domain| "  -d '#{domain}' \\\n"}
tmpl = <<~HEREDOC
certbot certonly \\
  --dns-cloudflare \\
  --dns-cloudflare-credentials #{credentials_file} \\
  --dns-cloudflare-propagation-seconds 60 \\
HEREDOC
full_tmpl = tmpl + domain_lines.join('')
puts full_tmpl

if Etc.getlogin == 'root'
  stdout, stderr, status = Open3.capture3(full_tmpl)
  if status.success?
    puts stdout
  else
    abort <<~HERE
    OUT: #{stdout}

    ERR: #{stderr}
  
    HERE
  end
end