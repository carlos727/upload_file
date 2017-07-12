# Cookbook Name:: upload_file
# Recipe:: log_chef
# Upload Log files of Eva Client Application
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings Chef' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_chef.erb'
  variables({
    :node_name => Chef.run_context.node.name
  })
end

ruby_block 'AzureUploader Chef (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Chef' do
  block do
    Dir.foreach('C:\chef') do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "C:\\chef\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?('C:\chef') }
end
