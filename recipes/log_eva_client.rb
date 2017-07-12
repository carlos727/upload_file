# Cookbook Name:: upload_file
# Recipe:: log_eva_cliente
# Upload Log files of Eva Client Application
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings Eva Client' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_eva_client.erb'
  variables({
    :node_name => Chef.run_context.node.name,
    :quantity  => -1
  })
end

ruby_block 'AzureUploader Eva Client (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Eva Client' do
  block do
    Dir.foreach('C:\Eva\Log') do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "C:\\Eva\\Log\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?('C:\Eva\Log') }
end
