package "pnp4nagios"

include_recipe "apache::mod_php5"

directory node['check_mk']['pnp4nagios']['perfdata_dir'] do
  mode "0755"
  owner node['check_mk']['nagios']['user']
  group node['apache']['group']
end

directory ::File.dirname(node['check_mk']['pnp4nagios']['npcd_config_file']) do
  mode "0755"
end

[::File.dirname(node['check_mk']['pnp4nagios']['log_dir']), node['check_mk']['pnp4nagios']['npcd_spool_dir'] ].each do |dir|
  directory dir do
    mode "0755"
    owner node['check_mk']['nagios']['user']
    group node['check_mk']['nagios']['group']
  end
end

template node['check_mk']['pnp4nagios']['npcd_config_file'] do
  source "ncpd.cfg.erb"
  mode "0644"
  notifies :restart, "service[npcd]"
end

