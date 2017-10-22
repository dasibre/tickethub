require 'rails_helper'

# models/physical/movies/movie.rb
# module Physical
#   module Movies
#     class Movie < ActiveRecord::Base
#     end
#   end
# end

# models/physical/orders/order.rb
# module Physical
#   module Orders
#     class Order < ActiveRecord::Base
#       belongs_to :movie,
#                  :class_name => '::Physical::Movies::Movie'
#     end
#   end
# end

module Physical
  module Movies
    describe Movie, :type => :model do
      it 'database should throw an error' do
        #lindeman = User.create!(first_name: "Andy", last_name: "Lindeman")
        #chelimsky = User.create!(first_name: "David", last_name: "Chelimsky")
        movie = Movie.new('foobar')
      end
    end
  end
end
# describe Physical::Movies::Mov, :type => :model do
#   describe 'No movie name' do
#
#   end
# end