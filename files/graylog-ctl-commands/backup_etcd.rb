add_command 'backup-etcd', 'Backup cluster informations stored in etcd', 2 do |cmd_name|
  require 'time'

  backup_dir = "/var/opt/graylog/backup/etcd/#{Time.now.to_i}"
  success = system "/opt/graylog/embedded/bin/etcdctl backup --data-dir /var/opt/graylog/data/etcd --backup-dir #{backup_dir}"
  if success
    puts "Backup created in #{backup_dir}"
  else
    puts "Backup failed, make sure etcd is running fine. Current database status:"
    system "/opt/graylog/embedded/bin/etcdctl cluster-health"
  end
end
