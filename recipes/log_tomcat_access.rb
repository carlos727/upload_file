# Cookbook Name:: upload_file
# Recipe:: log_tomcat_access
# Upload Log access files of Tomcat
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings Tomcat Access' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_tomcat_access.erb'
  variables({
    :node_name => Chef.run_context.node.name,
    :path_log => Tomcat.getLogFolder
  })
end

ruby_block 'AzureUploader Tomcat Access (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Tomcat Access' do
  block do
    Dir.foreach(Tomcat.getLogFolder) do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "#{Tomcat.getLogFolder}\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?(Tomcat.getLogFolder) }
end
