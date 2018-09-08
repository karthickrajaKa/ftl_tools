# tc_mongo.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'ftl_mongo'

class TestMongo < Test::Unit::TestCase

	def setup
		@collection	= 'people_test'
		conn_data = {:host => 'localhost', :port => 27017,
			:db => 'people', :coll => @collection}
		@conn = MongoConn.new(conn_data)
	end

	def teardown
		@conn.drop
	end

	def test_conn_exists
		assert(@conn.class == MongoConn)
	end

	def test_conn_count_equal_zero
		assert(@conn.count() == 0)	
	end

	def test_find_one_fail
		query		= {name: 'Fred Liebenbaumerben454545'}
		result	= @conn.find(query)
		assert(result.count			== 0)
	end

	def test_insert_one
		docs		= [ {"name": "Joaqim Domici", "rank": "Captain"}]
		insert	= @conn.insert(docs)
		query		= {"name": "Joaqim Domici"}
		result	= @conn.find(query)
		assert(result[0]["name"] == "Joaqim Domici")
		assert(result.count() 	>= 1)
	end

	def test_delete
		docs		= [ {"name": "Joaqim Domici", "rank": "Captain"}]
		insert	= @conn.insert(docs)
		docs		= [{"name": "Joaqim Domici"}]
		delete	= @conn.delete(docs)
		query		= {"name": "Joaqim Domici"}
		result	= @conn.find(query)
		assert(result.count() 	== 0)
	end

end
