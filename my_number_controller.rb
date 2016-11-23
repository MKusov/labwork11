require 'prime'
class MyNumberController < ApplicationController
  def input
  end

  def view
    n=params[:n].to_i
    if res = Number.find_by_num(n)
      @result = ActiveSupport::JSON::decode(res.result)
      @arr = @result.split.map(&:to_i)
    else
      @arr = (1..1.0/0.0).
          lazy.map{|x| 2**x - 1}
                 .take_while{|x| x < n}
                 .select{|x| Prime.prime?(x)}.to_a
      @result = @arr.join(' ')
      res = Number.create :num => n, :result => ActiveSupport::JSON::encode(@result)
      res.save
    end

  end

  def results
    @arr = Number.all
    render xml: @arr
  end
end
