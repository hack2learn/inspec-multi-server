desc 'Run inspec'
long_desc 'Run inspec tests on multiple servers.'

command :run do |c|
  c.flag([:stage], desc: 'stage', type: String, long_desc: 'Stage that InSpec is executed.', default_value: InSpecMultiServer::Config::Settings.default_stage)
  c.flag([:project], desc: 'project', type: String, long_desc: 'What project to run the InSpec tests.', default_value: InSpecMultiServer::Config::Settings.default_project)
  c.flag([:test], desc: 'test', type: String, long_desc: 'Which test you want to run.', default_value: 'all')

  c.action do |global_options,options,args|
    puts "Running InSpec...".colorize(:green)

    @show = options[:all] ? :all : :first
    @stage = options[:stage]
    @project = options[:project]
    @test = options[:test]
    @cookbook_directory = InSpecMultiServer::Config::Settings.current.data[@project][@stage]['path']

    validate

    puts "Current cookbook directory is: #{@cookbook_directory}".colorize(:light_blue)
    @settings = InSpecMultiServer::Config::Settings.current

    run_inspec_test

    puts "Done executing InSpec on #{@settings.data[@project][@stage]['servers'].size} servers. Check output above.".colorize(:yellow)
  end
end

def run_inspec_test
  @settings.data[@project][@stage]['servers'].each do |server|
    if @test.eql?('all')
      puts "Running all inspec tests on #{server['host']}".colorize(:yellow)
      command = "bundle exec inspec exec test/ -i #{server['publickey']} -t ssh://#{server['user']}@#{server['host']}"
    else
      puts "Running inspec test #{@test} on #{server['host']}".colorize(:yellow)
      command = "bundle exec inspec exec test/#{@test} -i #{server['publickey']} -t ssh://#{server['user']}@#{server['host']}"
    end
    puts "command: #{command}".colorize(:light_blue)
    output, error, status = Open3.capture3(command, :chdir=>@cookbook_directory)

    if error
      error = "Server #{server['host']} not found. Do you have access to the server #{server['host']}?" if error.include?('SocketError')
      if error.include?('zlib(finalizer): the stream was freed prematurely.')
        # needed because of bug in zlib
        puts error.colorize(:green)
        puts output.colorize(:green)
      else
        raise error
      end
    else
      # no error
      puts output.colorize(:green)
    end

    unless status.success?
      raise "Process did not complete succesfully, please check output."
    end
  end
end

def validate
  raise "Stage not found. Did you specify the right stage on the command line? " if @stage.nil?
  raise "Project not found. Did you specify the right project on the command line? " if @project.nil?
  raise "Test spec not found. Did you specify the right test on the command line" if @test.nil?
  raise "Test spec not found. Does the file actually exist? " unless @test == 'all' || File.exists?("#{cookbook_directory}/test/#{@test}")
  raise "Cookbook directory not found. Did you configure the json config ~/.inspec-multi-server?" if @cookbook_directory.nil?
end

# error handler
on_error do |ex|
  # evaluate to true or false
  puts "Sorry, there was an issue! #{ex}".colorize(:red)
end
