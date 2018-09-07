# ftl_mongo.rb
# Used to establish a MongoDB connection.
# Well, mostly used for the tests right now...

# Notes:
#		https://docs.mongodb.com/ruby-driver/master/quick-start/
#	Need to make this generic yet useful.

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'mongo'

class MongoConn
	def initialize(conn_data)
		@conn_data 	= conn_data
		@host				= @conn_data.fetch(:host, 'localhost')
		@port				= @conn_data.fetch(:port, 27017)
		@db					= @conn_data[:db]
		@coll				= @conn_data[:coll]
		init
	end

	def init
		Mongo::Logger.logger.level = Logger::WARN
		uri			= "mongodb://#{@host}:#{@port}/#{@db}"
 		client = Mongo::Client.new(uri)
 		@conn	 = client[@coll]
	end

	def count
		@conn.count()
	end

	def find(query)
		@conn.find(query).first
	end
end

