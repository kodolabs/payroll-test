# TODO: Make work cron on docker
every :day do
  rake 'payroll:create_in_new_period'
end
