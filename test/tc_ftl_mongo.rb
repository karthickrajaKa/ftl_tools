# tc_mongo.rb

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

require 'test/unit'
require 'ftl_mongo'

class TestMongo < Test::Unit::TestCase

	def setup
		conn_data = {:host => 'localhost', :port => 27017,
			:db => 'people', :coll => 'people'}
		@conn = MongoConn.new(conn_data)
		# This is a bad idea but a useful temporary test.
		@records = 1210
	end

	def test_conn_exists
		assert(@conn.class == MongoConn)
	end

	def test_conn_count_more_than_zero
		assert(@conn.count() > 0)	
	end

	def test_conn_count_equal_test_value
		assert(@conn.count() == @records)
	end	

	def test_find_one_good
		# This assumes 'Tala Domici' is in the data. 
		# Need to fix that assumption.
		query 	= {name: 'Tala Domici'}
		result	= @conn.find(query)
		expected	= 'CPT'	
		assert(result[0][:rank] == expected)
	end

	def test_find_one_fail
		query		= {name: 'Fred Liebenbaumerben454545'}
		result	= @conn.find(query)
		assert(result.count			== 0)
	end

	def test_find_many_good
		query		= {group: 'Dragons'}
		result 	= @conn.find(query)
		assert(result.count() > 100)
		assert(result.class		== Array)
	end
end
