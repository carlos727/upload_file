# Cookbook Name:: upload_file
# Recipe:: log_symmetric
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

template 'Settings Symmetric' do
  path 'C:\chef\AzureUploader\settings.config'
  source 'settings-log_symmetric.erb'
  variables({
    :node_name => Chef.run_context.node.name
  })
end

ruby_block 'AzureUploader Symmetric' do
  block do
    upload = powershell_out!($command)
    Chef::Log.info("\n#{upload.stdout.chop}")
  end
end

ruby_block 'Delete .zip File Symmetric' do
  block do
    Dir.foreach('C:\Eva\sym-localidad\logs') do |zipFile|
      next if !zipFile.start_with? Chef.run_context.node.name
      File.delete "C:\\Eva\\sym-localidad\\logs\\#{zipFile}" if zipFile.end_with? '.zip'
    end
  end
  only_if { File.directory?('C:\Eva\sym-localidad\logs') }
end
