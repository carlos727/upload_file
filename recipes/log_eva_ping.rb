# Cookbook Name:: upload_file
# Recipe:: log_eva_ping
# Upload Log files of Eva Ping Service
# Copyright (c) 2016 The Authors, All Rights Reserved.

aFolder = Chef.run_context.node.name.include?('-') ? 'EvaPing' : 'EvaPing2'

template 'Settings Eva Ping' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_eva_ping.erb'
  variables({
    :node_name => Chef.run_context.node.name,
    :azure_folder => aFolder
  })
end

ruby_block 'AzureUploader Eva Ping (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Eva Ping' do
  block do
    Dir.foreach('C:\Eva\Log') do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "C:\\Eva\\Log\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?('C:\Eva\Log') }
end
