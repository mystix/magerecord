module MageRecord
  class Connection
    def initialize(hostname, db, user, pwd)
      ActiveRecord::Base.establish_connection(
        adapter: 'mysql2',
        host: hostname,
        database: db,
        username: user,
        password: pwd
      )
    end
  end
end
