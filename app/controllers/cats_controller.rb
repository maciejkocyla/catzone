class CatsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :check_admin, only: [:index]
  
  def cat_mark
    @cat = Cat.random 2
  end
  
  def add_sweetness
    @cat = Cat.find(params[:id])
    
    respond_to do |format|
      format.js{
        @cat.sweetness.create!(value: 1)
        render :text => "success"
      }
    end
  end
  
  def index
    @cats = Kaminari.paginate_array(Cat.all_ordered).page(params[:page])
  end
  
  def top_today
    @cats = Cat.top_ten_in 1
    render 'top_ten'
  end
  
  def top_last_week
    @cats = Cat.top_ten_in 7  
    render 'top_ten'
  end
  
  def top_last_month
    @cats = Cat.top_ten_in 30
    render 'top_ten'
  end
  
  def top_ever
    @cats = Cat.top_ten
    render 'top_ten'
  end
  
  private
  
    def check_admin
      if !current_user.admin then redirect_to root_path end
    end

end