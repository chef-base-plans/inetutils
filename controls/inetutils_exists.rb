title 'Tests to confirm inetutils exists'

plan_name = input('plan_name', value: 'inetutils')
plan_ident = "#{ENV['HAB_ORIGIN']}/#{plan_name}"
inetutils_relative_path = input('command_path', value: '/bin/ping')
inetutils_installation_directory = command("hab pkg path #{plan_ident}")
inetutils_full_path = inetutils_installation_directory.stdout.strip + "#{inetutils_relative_path}"
 
control 'core-plans-inetutils-exists' do
  impact 1.0
  title 'Ensure inetutils exists'
  desc '
  '
   describe file(inetutils_full_path) do
    it { should exist }
  end
end
