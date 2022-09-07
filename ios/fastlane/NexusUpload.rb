class NexusUpload
  def self.run(params)
    command = []
    command << "mvn -s ${MAVEN_SETTINGS} deploy:deploy-file"
    command += upload_options(params)
    command << upload_url(params)
    puts command.join(' ')
    Fastlane::FastFile.new.sh(command.join(' '))
  end

  def self.upload_url(params)
    "-Durl=#{params[:endpoint]}/repository/#{params[:repo_id]}"
  end

  def self.upload_options(params)
    file_path = File.expand_path(params[:file]).shellescape

    options = []
    options << "-Dpackaging=#{params[:packaging].shellescape}"
    options << "-DgeneratePom=true"
    options << "-DrepositoryId=scb-dbank-maven-lib"
    options << "-Drepo.id=scb-dbank-maven-lib"
    options << "-Drepo.url=#{params[:endpoint].shellescape}/repository/#{params[:repo_id].shellescape}"
    options << "-DgroupId=#{params[:repo_group_id].shellescape}"
    options << "-DartifactId=#{params[:repo_project_name].shellescape}"
    options << "-Dversion=#{params[:repo_project_version].shellescape}"
    options << "-Dfile=#{file_path}"
    options
  end

  #####################################################
  # @!group Documentation
  #####################################################

  def self.description
    "Upload a file to Sonatype Nexus3 platform"
  end
end
