# Cookbook Name:: upload_file
# Recipe:: log_pdt_desktop
# Upload Log files of PDT Desktop Application
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings PDT Desktop' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_pdt_desktop.erb'
  variables({
    :node_name => Chef.run_context.node.name
  })
end

ruby_block 'AzureUploader PDT Desktop (PowerShell)' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File PDT Desktop' do
  block do
    Dir.foreach('C:\PDT\Log') do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "C:\\PDT\\Log\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?('C:\PDT\Log') }
end
