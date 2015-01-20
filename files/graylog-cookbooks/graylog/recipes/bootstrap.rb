bootstrap_status_file = "/var/opt/graylog/bootstrapped"

file bootstrap_status_file do
  owner "root"
  group "root"
  mode "0600"
  content "All your bootstraps are belong to Chef"
end
