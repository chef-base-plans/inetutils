title 'Tests to confirm inetutils works as expected'

plan_name = input('plan_name', value: 'inetutils')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"

control 'core-plans-inetutils-works' do
  impact 1.0
  title 'Ensure inetutils works as expected'
  desc '
  '
  inetutils_path = command("hab pkg path #{plan_ident}")
  describe inetutils_path do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
  end
  
  inetutils_pkg_ident = ((inetutils_path.stdout.strip).match /(?<=pkgs\/)(.*)/)[1]
  describe command("DEBUG=true; hab pkg exec #{inetutils_pkg_ident} ping --version") do
    its('exit_status') { should eq 0 }
    its('stdout') { should_not be_empty }
    its('stdout') { should match /ping \(GNU inetutils\) 1.9.4/ }
    its('stderr') { should be_empty }
  end
end
