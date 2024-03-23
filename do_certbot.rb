#! /usr/bin/env ruby
require 'open3'
require_relative 'do_certbot_xtra/find_creds'
domains = [
  '*.electrocode.net',
  '*.iotaspencer.me',
  '*.e-code.in',
  'e-code.in',
  'electrocode.net',
  'iotaspencer.me'
]
domain_lines = domains.map {|domain| "-d '#{domain}'"}
puts domain_lines

tmpl = <<~HEREDOC
certbot certonly \
  --dns-cloudflare \
  --dns-cloudflare-credentials #{credentials_file}
HEREDOC