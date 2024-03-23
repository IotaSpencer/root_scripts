# Do testing on what exists
def get_creds_file
  places_to_check = {
    secrets: "~/.secrets/certbot/cloudflare.ini",
    cloudflare_dir: "~/.cloudflare/cloudflare.cfg"

  }
  outcome = {
    secrets: nil,
    cloudflare_dir: nil,

  }
  credentials_file = nil
  for name, path in places_to_check
    if File.exist? File.expand_path(path)
      outcome[name] = true
      puts 'found secrets'
    else
      outcome[name] = false
      puts 'found cloudflare_dir'
    end
  end
  outcome_secrets = outcome[:secrets]
  outcome_cf_dir = outcome[:cloudflare_dir]
  if outcome
    if outcome_secrets == true
      credentials_file = File.expand_path(places_to_check[:secrets])
    elsif outcome_secrets == false && outcome_cf_dir == true
      credentials_file = File.expand_path(places_to_check[:cloudflare_dir])
    elsif outcome_cf_dir == false && outcome_secrets == false
      credentials_file = nil
      STDERR.puts "Unable to find valid credentials file"
      STDERR.puts "Stopping!..."
      exit(1)
    end
  end
end