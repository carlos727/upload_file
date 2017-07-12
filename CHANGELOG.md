# CHANGELOG

##### v1.6.1 08/03/2017:

- Now the servers upload log of Eva Ping also.

- Parameter `azure_folder` was added to `settings-log_eva_ping` template.

##### v1.6.0 20/01/2017:

- New `log_flytech.rb` recipes the code to upload logs of Flytech application and it was included in `default.rb` recipe.

- New `settings-log_flytech.erb` template to configure `AzureUploader.exe` execution.

##### v1.5.1 10/12/2017:

- Parameter `quantity` was added to `settings-log_eva_client` template.

##### v1.5.0 05/01/2017:

- New `log_eva_ping.rb` recipes the code to upload logs of Eva Ping Service and it was included in `default.rb` recipe.

- New `settings-log_eva_ping.erb` template to configure `AzureUploader.exe` execution.

##### v1.4.1 26/12/2016:

- Now the logs are collected the next day.

- A condition was added in `default.rb` to avoid uploading files in a different hour of the day.

##### v1.4.0 22/12/2016:

- New `log_tomcat_access.rb` recipes the code to upload logs of tomcat access and it was included in `default.rb` recipe.

- New `settings-log_tomcat_access.erb` template to configure `AzureUploader.exe` execution.

- Module `Eva` was replaced by `Tomcat` module and it includes `getLogFolder` function.

##### v1.3.1 01/12/2016:

- New `ruby_block 'Delete .zip File ******'` resource to delete .zip files send to Azure Storage.

##### v1.3.0 30/11/2016:

- New `log_chef.rb` recipes the code to upload logs of Chef and it was included in `default.rb` recipe.

- New `settings-log_chef.erb` template to configure `AzureUploader.exe` execution.

##### v1.2.0 24/11/2016:

- New `log_symmetric.rb` recipes the code to upload logs of Symmetric.

- Recipe `log_symmetric.rb` was included in `default.rb` recipe and it is executed by nodes type server.

- New `settings-log_symmetric.erb` template to configure `AzureUploader.exe` execution.

##### v1.1.3 23/11/2016:

- Method `Mixlib::ShellOut.new` didn't work fine, resource `ruby_block 'AzureUploader ****** (CMD)'` was deleted.

- Application `AzureUploader.exe` requires .NET Framework 4.5.1 or higher.

##### v1.1.2 22/11/2016:

- Global variable `$command` was added in `default.rb` recipe to pass a multiline string to `powershell_out!` and `Mixlib::ShellOut.new` method.

- Now, if `ruby_block 'AzureUploader ****** (PowerShell)'` resources fail Chef uses `ruby_block 'AzureUploader ****** (CMD)'` resource to run `AzureUploader.exe`.

- Delete unnecesary variables `log_eva_server`, `log_eva_client` and `log_pdt_desktop`.

##### v1.1.1 21/11/2016:

- The execution of `AzureUploader.exe` changed from `powershell_script` to `ruby_block` resource with `powershell_out!` method.

- Other `ruby_block` resource was added to execute `AzureUploader.exe` with `CMD` if node can not run PowerShell scripts.

##### v1.1.0 18/11/2016:

- Now, the download of AzureUploader is managed in `default.rb` recipe.

- New `log_eva_server.rb` and `log_pdt_desktop.rb` recipes.

- Recipe `log_eva_server.rb` has the code to upload logs of Eva server.

- Recipe `log_pdt_desktop.rb` has the code to upload logs of PDT desktop application.

- New templates `settings-log_eva_server.erb` and `settings-log_pdt_desktop.erb` allow configuring the AzureUploader.

- New recipes were included in `default.rb` recipe and located into `if` or `unless` statement to only be executed according to the node's type.

##### v1.0.0 15/11/2016:

- Recipe `log_eva_client.rb` has the code to upload logs of Eva client.

- Recipe `log_eva_client.rb` was included in ´default.rb´ recipe.

- Template `settings-log_eva_client.erb` and attribute `default["uploader"]["url"]` configure the system.
