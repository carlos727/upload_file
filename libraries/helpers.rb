module Tomcat

  # Function to get the war folder
  def self.getLogFolder
    if File.directory?('C:\Program Files (x86)\Apache Software Foundation\Tomcat 7.0\logs')
      return 'C:\Program Files (x86)\Apache Software Foundation\Tomcat 7.0\logs'
    else
      return 'C:\Program Files\Apache Software Foundation\Tomcat 7.0\logs'
    end
  end

end

Chef::Recipe.send(:include, Tomcat)
