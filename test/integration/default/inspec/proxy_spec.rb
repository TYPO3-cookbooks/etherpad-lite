control 'etherpad-2' do
  title 'Etherpad Proxy Setup'
  desc 'Check that nginx as proxy is installed and running'

  [80].each do |listen_port|
    describe port(listen_port) do
      it { should be_listening }
      its('protocols') { should include 'tcp' }
    end
  end

  # not listening on 443
  describe port(443) do
    it { should_not be_listening }
  end

  # port 80 HTML
  describe command('curl --resolve "etherpad.vagrant:80:127.0.0.1" http://etherpad.vagrant') do
    its('exit_status') { should eq 0 }
    its('stdout') { should include '<title>Etherpad</title>' }
  end

end
