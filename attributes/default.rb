# common attributes
default['rails']['server_name'] = 'dev.rails'
default['rails']['app_name']    = 'devise_sample'

# rails attributes
default['rails']['ruby_version'] = '2.1.1'


# passenger attributes
default['passenger']['max_pool_size'] = 6


# mysql attributes
default['rails']['db_name']     = 'devise_sample_db'
default['rails']['db_admin']    = 'db_admin'
default['rails']['db_admin_pass']    = 'db_admin_pass'
default['rails']['db_app_user'] = 'db_app_user'
default['rails']['db_app_user_pass'] = 'db_app_user_pass'

# jenkins attributes
default['rails']['job_name']   = 'devise_sample_test'

