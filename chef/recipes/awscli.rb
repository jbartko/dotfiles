python_execute '-m pip install awscli' do
  not_if 'pip show awscli >/dev/null 2>&1'
end
