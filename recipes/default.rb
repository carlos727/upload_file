# Cookbook Name:: upload_file
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

$node_name = Chef.run_context.node.name.to_s
$command = <<-SCRIPT
cd C:\\chef\\AzureUploader
.\\AzureUploader.exe
SCRIPT

if $node_name.include?('-') && !$node_name.start_with?('B')
  include_recipe 'edit_file'
end

directory 'C:\chef\AzureUploader' do
  recursive true
  action :delete
  only_if { File.directory?('C:\chef\AzureUploader') }
end

windows_zipfile 'C:\chef\AzureUploader' do
  source node[:uploader][:url]
  action :unzip
end


if Time.now.strftime("%H").to_i >= 7 && Time.now.strftime("%H").to_i < 22

  if Chef.run_context.node.name.include?('B') || Chef.run_context.node.name.include?('-')

    include_recipe 'upload_file::log_eva_client'

  else

    include_recipe 'upload_file::log_pdt_desktop'

  end

  unless Chef.run_context.node.name.include? "-"

    include_recipe 'upload_file::log_eva_server'
    include_recipe 'upload_file::log_symmetric'
    include_recipe 'upload_file::log_tomcat_access'

  else

    include_recipe 'upload_file::log_flytech'

  end

  include_recipe 'upload_file::log_eva_ping'
  include_recipe 'upload_file::log_chef'

end
