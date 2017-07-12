# Cookbook Name:: upload_file
# Recipe:: log_eva_server
# Upload Log files of Eva Server Application
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings Eva Server' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_eva_server.erb'
  variables({
    :node_name => Chef.run_context.node.name,
    :path_log => "#{Tomcat.getLogFolder}\\Eva"
  })
end

ruby_block 'AzureUploader Eva Server (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Eva Server' do
  block do
    Dir.foreach("#{Tomcat.getLogFolder}\\Eva") do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "#{Tomcat.getLogFolder}\\Eva\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?("#{Tomcat.getLogFolder}\\Eva") }
end
