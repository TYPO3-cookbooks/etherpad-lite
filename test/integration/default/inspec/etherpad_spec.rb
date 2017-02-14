control 'etherpad-1' do
  title 'Etherpad-lite Setup'
  desc 'Check that etherpad is installed and running'

  describe port(9001) do
    it { should be_listening }
    its('protocols') { should include 'tcp' }
  end

  # port 9001 HTML
  describe command('curl http://localhost:9001') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include '<title>Etherpad</title>' }
  end

end
