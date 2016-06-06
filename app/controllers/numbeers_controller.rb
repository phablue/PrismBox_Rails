class NumbeersController < ApplicationController
  def fibonacci
    @result = fibo_calculater(params[:index].to_i)
  end

  def fibo_calculater(index)
    fibo_numbers = [1, 1]

    if index > 2
      (2...index).each do |i|
        fibo_numbers << fibo_numbers[i - 2] + fibo_numbers[i - 1]
      end
    end

    fibo_numbers[index-1]
  end
end
